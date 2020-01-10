//
//  POPStrings.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import UIKit

struct BNStrings {
    
    struct EndPoint {
        static let value = "https://api.chucknorris.io/jokes/"
    }
    
    struct Alerta {
        static let noConnection = "No connection."
        static let erroConnection = "Please check your internet connection."
        static let noSearch = "It looks like you haven't seen any facts yet."
    }
    
    struct Resposta {
        static let noResults = "Your search returned no results!"
        static let sizeSearch = "Size must be between 3 and 120."
    }
    
    struct Status {
        static let loading = "Loading..."
    }
    
}
