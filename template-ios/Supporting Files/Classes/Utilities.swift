//
//  Utilities.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialDialogs

func performForUI(_ callback: () -> Void) {
    callback()
}

func delay(_ delay: Double, closure: @escaping ()-> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

struct Utilities {
    static func showSnackbar(with text: String,
                            font: UIFont = .avenirHeavy16,
                            textColor: UIColor = .white,
                            backgroundColor: UIColor = .te_black,
                            dismissBlock: (() -> Void)? = nil) {
        
        
        
        let message = MDCSnackbarMessage()
        message.text = text
        MDCSnackbarManager.show(message)
    }
    
    static func showError(title: String, message: String, in viewController: UIViewController ) {
        // Present a modal alert
        let alertController = MDCAlertController(title: title, message: message)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        
        viewController.present(alertController, animated:true, completion: nil)
    }
}
