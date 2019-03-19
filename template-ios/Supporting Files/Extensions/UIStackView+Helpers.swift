//
//  UIStackView+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 1/14/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        for oldItem in self.arrangedSubviews {
            oldItem.removeFromSuperview()
        }
    }
}

