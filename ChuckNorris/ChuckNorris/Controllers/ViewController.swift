//
//  ViewController.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON

class ViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chuck Norris Facts"
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CategoriesDAO.getCategories().isEmpty {
            saveCategories()
        }
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func saveCategories() {
        self.startAnimating(message: BNStrings.Status.loading)
        APIManager.sharedInstance.request(route: .categories) { (json) in
            self.stopAnimating()
            if let array = json.arrayObject as? [String] {
                CategoriesDAO.saveCategories(result: array)
            }
        }
    }
    
    @IBAction func searchFacts(_ sender: UIBarButtonItem) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")
            as? SearchViewController {
            self.show(controller, sender: self)
        }
    }
    
    func shareURL(url: String) {
        let objectsToShare: URL = URL(string: url)!
        let activityViewController = UIActivityViewController(activityItems : [objectsToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lbEmpty.isHidden = FactsDAO.getFacts().count == 0 ? false : true
        lbEmpty.text = FactsDAO.getFacts().count == 0 ? BNStrings.Alerta.noSearch : ""
        return FactsDAO.getFacts().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellFact", for: indexPath) as? FactCell else {
            return FactCell()
        }
        let facts = Array(FactsDAO.getFacts())
        cell.lbFact.text = facts[indexPath.row].value
        cell.lbFact.font = checkTextSize(facts[indexPath.row].value) ? cell.lbFact.font.withSize(16) : cell.lbFact.font.withSize(22)
        cell.lbCategory.text = facts[indexPath.row].categories
        cell.btShare.tag = indexPath.row
        cell.btShare.addTarget(self, action: #selector(clickShare(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func checkTextSize(_ text: String) -> Bool {
        return text.count > 80
    }
    
    @objc func clickShare(sender: UIButton) {
        let facts = Array(FactsDAO.getFacts())
        self.shareURL(url: facts[sender.tag].url)
    }
    
}
