//
//  UITextView+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 1/10/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import SnapKit

extension UITextView {
    func addDoneButton(callback: (() -> Void)? = nil) {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = true
        toolbar.tintColor = .br_wine
        toolbar.backgroundColor = .white
        let closeBarButtonItem = BarButtonItem(title: "Listo", onClick: { _ in
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
}
