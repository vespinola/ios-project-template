//
//  GradientColor.swift
//  template-ios
//
//  Created by Vladimir Espinola on 5/30/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

class GradientColor {
    var gl: CAGradientLayer!
    
    init(top: UIColor, bottom: UIColor) {
        self.gl = CAGradientLayer()
        self.gl.colors = [top.cgColor, bottom.cgColor]
        self.gl.locations = [0.0, 1.0]
    }
    
    init(colors: [UIColor], locations: [NSNumber]? = nil) {
        self.gl = CAGradientLayer()
        self.gl.colors = colors.map { $0.cgColor }
        self.gl.locations = locations
    }
}
