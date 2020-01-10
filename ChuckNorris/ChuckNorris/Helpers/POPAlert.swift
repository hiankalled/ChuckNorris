//
//  POPAlert.swift
//  ChuckNorris
//
//  Created by Hian Kalled on 10/01/20.
//  Copyright © 2020 Hian Kalled. All rights reserved.
//

import UIKit
import SwiftMessages

class POPAlert {
    
    static let sharedInstance = POPAlert()
    
    fileprivate let messageWarning: MessageView = {
        
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureDropShadow()
        messageView.configureTheme(.error, iconStyle: .light)
        messageView.button?.isHidden = true
        messageView.tapHandler = { _ in SwiftMessages.hide() }
        
        return messageView
    }()
    
    func showWarning(title: String = "Erro", message: String) {
        messageWarning.configureContent(title: title, body: message)
        SwiftMessages.show(view: messageWarning)
    }
    
}
