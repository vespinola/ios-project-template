//
//  Measurement+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 2/13/19.
//  Copyright © 2019 vel. All rights reserved.
//

import UIKit

typealias Angle = Measurement<UnitAngle>

extension Measurement where UnitType == UnitAngle {
    init(degrees: Double) {
        self.init(value: degrees, unit: .degrees)
    }
    
    func toRadians() -> CGFloat {
        return CGFloat(converted(to: .radians).value)
    }
}
