//
//  Double+Extensions.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

extension Double {
    /// Formats Float price using "Decimal" number formatter **without currency** symbol
    ///
    /// - Returns: Formatted string with given parameters.
    
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let priceString = formatter.string(from: NSNumber(value: self)) ?? ""
        return priceString
    }
    
    /// Formats a `Double` value as a percentage string with optional locale.
    /// - Parameters:
    ///   - locale: An optional `Locale` object to use for formatting.
    /// - Returns: A percentage string formatted from the `Double` value.
    func percentFormatted(locale: Locale = .current) -> String? {
        let number = (self / 100) as NSNumber
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.locale = locale
        numberFormatter.maximumFractionDigits = 3
        return numberFormatter.string(from: number)
    }
}

