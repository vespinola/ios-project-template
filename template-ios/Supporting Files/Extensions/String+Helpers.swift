//
//  String+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 1/7/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var trimmed: String? {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank: Bool {
        return trimmed?.isEmpty == true
    }
    
    var hasValue: Bool {
        return isBlank == false
    }
    
    var isValidEmail: Bool {
        return self.isValid(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    var isValidPhone: Bool {
        return self.isValid(regex: "\\(?(09)\\)?([0-9]{8})")
    }

    func isValid(regex: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", regex.trimmed!)
        return test.evaluate(with: self)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
