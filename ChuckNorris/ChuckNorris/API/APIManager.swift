//
//  APIManager.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let sharedInstance = APIManager()
    private let baseURL = BNStrings.EndPoint.value
    
    func request(route: ChuckNorrisRouter, value: String = "", completion: @escaping (JSON) -> Void) {
        let endPoint = baseURL + route.value + value
        printAccess(baseURL + route.value, value)
        if POPDevice.checkConnection() {
            AF.request(endPoint, method: .get).responseJSON { response in
                switch response.result {
                case .success(let json):
                    let json = JSON(json)
                    if json != JSON.null {
                        completion(json)
                    }
                case .failure(let error):
                    POPAlert.sharedInstance.showWarning(message: "\(error)")
                }
            }
        }
    }
    
    private func printAccess(_ endPoint: String, _ parameters: String){
        let param: Any = parameters.isEmpty ? "---" : parameters
        print("\n ======== URL ACCESS ======== \n - URL:\n \(endPoint) \n\n - PARAMETERS:\n \(param)\n ============================ \n")
    }
    
}
