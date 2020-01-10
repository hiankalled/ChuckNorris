//
//  SearchViewController.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON
import TagListView

class SearchViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableViewSearches: UITableView!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lbSearches: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Facts"
        self.navigationItem.rightBarButtonItem = nil
        configureSearches()
        configureTagView()
    }
    
    private func configureSearches() {
        searchBar.delegate = self
        tableViewSearches.delegate = self
        tableViewSearches.dataSource = self
        lbSearches.isHidden = SearchDAO.getPastSearches().count == 0
    }
    
    private func configureTagView() {
        tagView.delegate = self
        tagView.textFont = UIFont.boldSystemFont(ofSize: 20)
        let categories = Array(CategoriesDAO.getCategories())
        let randomCategories = categories.shuffled()
        for (i, category) in randomCategories.enumerated() {
            if i < 8 {
                tagView.addTag(category.name.uppercased())
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchDAO.getPastSearches().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearches", for: indexPath) as UITableViewCell
        let suggestions = Array(SearchDAO.getPastSearches().reversed())
        cell.textLabel?.text = suggestions[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let suggestions = Array(SearchDAO.getPastSearches().reversed())
        saveFacts(suggestions[indexPath.row].name)
    }
    
    public func saveFacts(_ name: String) {
        self.startAnimating(message: BNStrings.Status.loading)
        APIManager.sharedInstance.request(route: .search, value: name.lowercased()) { (json) in
            self.stopAnimating()
            if json["result"].count != 0 {
                FactsDAO.saveFacts(result: json["result"].arrayValue)
                SearchDAO.saveSearch(name: name)
                self.navigationController?.popViewController(animated: true)
            } else {
                POPAlert.sharedInstance.showWarning(message: BNStrings.Resposta.noResults)
            }
        }
    }
    
}

extension SearchViewController: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        self.startAnimating(message: BNStrings.Status.loading)
        APIManager.sharedInstance.request(route: .category, value: title.lowercased()) { (json) in
            self.stopAnimating()
            FactsDAO.saveFacts(result: [json])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let name = searchBar.text,
            name.count > 2, name.count < 120 {
            saveFacts(name)
        } else {
            POPAlert.sharedInstance.showWarning(message: BNStrings.Resposta.sizeSearch)
        }
    }
    
}

