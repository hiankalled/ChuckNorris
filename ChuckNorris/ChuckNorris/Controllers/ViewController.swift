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
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellFact", for: indexPath) as? FactCell else {
            return FactCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
