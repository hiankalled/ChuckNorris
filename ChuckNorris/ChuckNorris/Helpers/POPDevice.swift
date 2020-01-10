//
//  POPDevice.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class POPDevice {
    
    static func checkConnection() -> Bool {
        if isConnectedToNetwork() {
            return true
        }
        POPAlert.sharedInstance.showWarning(title: BNStrings.Alerta.noConnection, message: BNStrings.Alerta.erroConnection)
        return false
    }
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}
