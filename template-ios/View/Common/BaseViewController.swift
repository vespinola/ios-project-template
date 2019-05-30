//
//  BaseViewController.swift
//  template-ios
//
//  Created by Vladimir Espinola on 5/29/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit
import MaterialComponents.MDCActivityIndicator

class BaseViewController: UIViewController {
    
    private var activityIndicator: MDCActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = MDCActivityIndicator()
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        activityIndicator.sizeToFit()
        activityIndicator.isHidden = true
        activityIndicator.radius = 24
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func showActivityIndicator() {
        // To make the activity indicator appear:
        performForUI {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        // To make the activity indicator disappear:
        performForUI {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
