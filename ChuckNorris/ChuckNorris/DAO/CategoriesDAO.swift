//
//  CategoriesDAO.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import RealmSwift

class CategoriesDAO {
    
    static func saveCategories(result: [String]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Category.self))
            for category in result {
                let newCategory = Category()
                newCategory.name = category
                realm.add(newCategory)
            }
        }
    }
    
    static func getCategories() -> Results<Category> {
        return try! Realm().objects(Category.self)
    }
    
}
