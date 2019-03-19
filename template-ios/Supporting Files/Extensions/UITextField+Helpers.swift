//
//  UITextField+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 1/10/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

extension UITextField {
    func addDoneButton(callback: (() -> Void)? = nil) {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = true
        toolbar.tintColor = .br_wine
        toolbar.backgroundColor = .white
        let closeBarButtonItem = BarButtonItem(title: "Done", onClick: { _ in
            self.resignFirstResponder()
            callback?()
        })
        let spaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceBarButtonItem, closeBarButtonItem], animated: false)
        let toolbarWrapperView = UIView()
        toolbarWrapperView.addSubview(toolbar)
        
        toolbar.snp.makeConstraints { make in
            make.margins.equalTo(0)
        }
        
        self.inputAccessoryView = toolbar
        self.inputAccessoryView!.backgroundColor = UIColor.white
    }
    
    func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        
        if let existingText = text, isSecureTextEntry {
            /* When toggling to secure text, all text will be purged if the user
             continues typing unless we intervene. This is prevented by first
             deleting the existing text and then recovering the original text. */
            deleteBackward()
            
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        /* Reset the selected text range since the cursor can end up in the wrong
         position after a toggle because the text might vary in width */
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
}
