//
//  UIButton+Helpers.swift
//  Dominos
//
//  Created by Vladimir Espinola on 2/5/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

extension UIButton {
    func setupDefaultStyle() {
        backgroundColor = .br_black
        setTitleColor(.br_white, for: .normal)
        titleLabel?.font = .avenirHeavy20
        layer.masksToBounds = true
        layer.cornerRadius = .leastNormalMagnitude
    }
}
