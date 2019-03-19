//
//  Date+Helpers.swift
//  
//
//  Created by Vladimir Espinola on 1/21/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

extension Date {
    
    var firstDayOfMonthDate: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    var lastDayOfMonthDate: Date {
        var comp: DateComponents = Calendar.current.dateComponents([.month, .day, .hour], from: Calendar.current.startOfDay(for: self))
        comp.month = 1
        comp.day = -1
        return Calendar.current.date(byAdding: comp, to: self.firstDayOfMonthDate)!
    }
    
    var formattedTime: String {
        return format(with: "HH:mm") + " Hs."
    }
    
    var formatted: String {
        return format(with: "dd-MM-yyyy")
    }
    
    private func format(with format: String) -> String {
        let dateFormatter = DateFormatter()
        let enUSPOSIXLocale = Locale(identifier: "es_PY_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
