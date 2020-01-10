//
//  FactsDAO.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class FactsDAO {
    
    static func saveFacts(result: [JSON]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Fact.self))
            for fact in result {
                let newFact = Fact()
                newFact.id = fact["id"].stringValue
                newFact.created_at = fact["created_at"].stringValue
                newFact.icon_url = fact["icon_url"].stringValue
                newFact.value = fact["value"].stringValue
                newFact.updated_at = fact["updated_at"].stringValue
                newFact.categories = (fact["categories"].arrayObject as? [String])?.first?.uppercased() ?? "UNCATEGORIZED"
                newFact.url = fact["url"].stringValue
                realm.add(newFact)
            }
        }
    }
    
    static func getFacts() -> Results<Fact> {
        return try! Realm().objects(Fact.self)
    }
    
}

