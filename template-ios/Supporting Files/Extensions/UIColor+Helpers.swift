//
//  UIColor+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 2/25/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
    
    static var br_black: UIColor {
        return UIColor(netHex: 0x272827)
    }
    
    static var br_pink: UIColor {
        return UIColor(netHex: 0xE8CDCD)
    }
    
    static var br_white: UIColor {
        return UIColor(netHex: 0xF5ECEA)
    }
    
    static var br_gray: UIColor {
        return UIColor(netHex: 0xA39998)
    }
    
    static var br_wine: UIColor {
        return UIColor(netHex: 0x673242)
    }
    
    static var br_green: UIColor {
        return UIColor(netHex: 0x09AF00)
    }
    
    //Pastel
    static var br_pred: UIColor {
        return UIColor(netHex: 0xEF5350)
    }
    
    static var br_pgreen: UIColor {
        return UIColor(netHex: 0x43A047)
    }
    
    static var br_porange: UIColor {
        return UIColor(netHex: 0xE65100)
    }
}
