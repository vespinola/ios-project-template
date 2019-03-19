//
//  Amount.swift
//
//
//  Created by Vladimir Espinola on 1/8/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation

typealias Amount = NSDecimalNumber

enum CurrencyType: RawRepresentable {
    
    case pyg
    case usd
    
    typealias RawValue = String
    
    public init?(rawValue: String) {
        switch rawValue {
        case "PYG", "GS":
            self = .pyg
        case "USD":
            self = .usd
        default:
            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .pyg:
            return "PYG"
        case .usd:
            return "USD"
        }
    }
    
    var symbol: String {
        get {
            switch self {
            case .pyg:
                return "Gs."
            case .usd:
                return "USD."
            }
        }
    }
    
}

extension Amount {
    
    func formatAs(currency: CurrencyType, showsCurrency: Bool = true) -> String? {
        
        guard currency == .pyg else {
            let formatter = CurrencyFormatter()
            formatter.decimalSeparator = .comma
            formatter.thousandSeparator = .dot
            formatter.prefix = .none
            
            if showsCurrency {
                let result = currency.symbol + " " + formatter.string(from: self.doubleValue)
                return result
            }
            
            return formatter.string(from: self.doubleValue)
        }
        
        let GROUPING_SEPARATOR = "."
        let DECIMAL_SEPARATOR = ","
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = GROUPING_SEPARATOR
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = DECIMAL_SEPARATOR
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        
        guard let formattedAmount = formatter.string(from: self) else {
            return nil
        }
        if showsCurrency {
            let result = currency.symbol + " " + formattedAmount
            return result
        }
        
        return formattedAmount
    }
    
    var isGreaterThanZero: Bool {
        get {
            return compare(NSDecimalNumber.zero) == ComparisonResult.orderedDescending
        }
    }
    
    func multiplying(by factor: Int) -> Amount{
        return self.multiplying(by: Amount(value: factor), withBehavior: NSDecimalNumberBehaviors?.none)
    }
}

extension String {
    func unformatAmount(with currency: CurrencyType? = .pyg) -> Amount? {
        guard self.hasValue else { return nil }
        
        let defaultConfiguration: () -> Amount? = {
            var comps = self.components(separatedBy: " ")
            
            // Discard anything after a space, e.g. "34.434,54 U$D." -> "34.434,54"
            let raw = comps[0].replacingOccurrences(of: ".", with: "")
            let num = Amount(string: raw)
            if num != .notANumber {
                return num
            } else {
                return nil
            }
        }
        
        guard let currencyType = currency else {
            return defaultConfiguration()
        }
        
        guard currencyType == .usd else { return defaultConfiguration() }
        
        let formatter = CurrencyFormatter()
        return Amount(value: formatter.double(from: self))
    }
    
    func reformatAmountInRange(range: NSRange, string: String, currencyType: CurrencyType) -> String? {
        let newText = (self as NSString).replacingCharacters(in: range, with: string)
        let newRawAmount = newText.unformatAmount(with: currencyType)
        let newlyFormattedAmountString = newRawAmount?.formatAs(currency: currencyType, showsCurrency: false)
        return newlyFormattedAmountString
    }
}
