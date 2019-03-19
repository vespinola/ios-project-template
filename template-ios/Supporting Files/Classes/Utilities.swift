//
//  Utilities.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation
import TTGSnackbar
import NotificationBannerSwift

class Utilities {
    class func showSnackbar(with message: String,
                            font: UIFont = .avenirHeavy16,
                            textColor: UIColor = .white,
                            backgroundColor: UIColor = .te_black,
                            dismissBlock: TTGSnackbar.TTGDismissBlock? = nil) {
        let snackbar = TTGSnackbar(message: message, duration: .long)
        
        // Set text color
        snackbar.messageTextColor = textColor
        
        // Set font
        snackbar.messageTextFont = font
        
        // Set background
        snackbar.backgroundColor = backgroundColor
        
        // Add the gesture recognizer callbacks
        snackbar.onTapBlock = { snackbar in
            snackbar.dismiss()
        }
        
        snackbar.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        snackbar.bottomMargin = Metrics.defaultPadding
        
        snackbar.dismissBlock = dismissBlock
        
        snackbar.onSwipeBlock = { (snackbar, direction) in
            
            // Change the animation type to simulate being dismissed in that direction
            if direction == .right {
                snackbar.animationType = .slideFromLeftToRight
            } else if direction == .left {
                snackbar.animationType = .slideFromRightToLeft
            } else if direction == .up {
                snackbar.animationType = .slideFromTopBackToTop
            } else if direction == .down {
                snackbar.animationType = .slideFromTopBackToTop
            }
            
            snackbar.dismiss()
        }
        
        snackbar.show()
    }
    
    class func showError(title: String, subtitle: String = "") {
        GrowingNotificationBanner(title: title, subtitle: subtitle, style: .danger, colors: CustomBannerColors()).show()
    }
}
