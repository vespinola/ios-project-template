//
//  BarButtonItem.swift
//
//
//  Created by Vladimir Espinola on 1/10/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {
    var onClick: ((BarButtonItem) -> Void)?
    
    convenience init(title: String?, onClick: ((BarButtonItem) -> Void)!) {
        self.init(title: title, style: UIBarButtonItem.Style.plain, onClick: onClick)
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style, onClick: ((BarButtonItem) -> Void)!) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(buttonPressed(sender:))
        self.onClick = onClick
    }
    
    convenience init(named: String, action: ((BarButtonItem) -> Void)!) {
        let image = UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
        self.init(image: image, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.target = self
        self.action = #selector(buttonPressed(sender:))
        self.onClick = action
    }
    
    convenience init(barButtonSystemItem: UIBarButtonItem.SystemItem, onClick: ((BarButtonItem) -> Void)!) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: #selector(buttonPressed(sender:)))
        self.target = self
        self.onClick = onClick
    }
    
    @objc func buttonPressed(sender: BarButtonItem) {
        onClick?(sender)
    }
    
}
