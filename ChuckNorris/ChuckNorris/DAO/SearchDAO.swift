//
//  SearchDAO.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SearchDAO {
    
    static func saveSearch(name: String) {
        let realm = try! Realm()
        try! realm.write {
            if let existName = realm.object(ofType: Search.self, forPrimaryKey: name) {
                realm.delete(existName)
            }
            let newName = Search()
            newName.name = name
            realm.add(newName)
        }
    }
    
    static func getPastSearches() -> Results<Search> {
        return try! Realm().objects(Search.self)
    }
    
}

