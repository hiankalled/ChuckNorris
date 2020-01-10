//
//  Fact.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import RealmSwift

class Fact: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var created_at = ""
    @objc dynamic var icon_url = ""
    @objc dynamic var value = ""
    @objc dynamic var updated_at = ""
    @objc dynamic var categories = "UNCATEGORIZED"
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
