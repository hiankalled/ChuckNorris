//
//  EndPoint.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation

enum ChuckNorrisRouter: String {
    
    case category = "random?category="
    case categories = "categories"
    case search = "search?query="
    case random = "random"
    
    var value: String {
        get {
            return self.rawValue
        }
    }
    
}
