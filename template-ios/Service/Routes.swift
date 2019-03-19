//
//  Routes.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

enum Routes: String {
    case endpoint = "endpoint"
    
    var endpoint: String {
        return "define base url" + self.rawValue
    }
}
