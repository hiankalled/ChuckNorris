//
//  Search.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import RealmSwift

class Search: Object {
    
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
