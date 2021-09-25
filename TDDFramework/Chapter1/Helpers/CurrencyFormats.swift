//
//  CurrencyFormats.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

//https://www.swiftbysundell.com/articles/formatting-numbers-in-swift/
func usd(_ aNumber: Int) -> String {
    func getUSDFormater() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        //                formatter.locale = Locale.current
        // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        return formatter
    }
    let aDouble = Double(aNumber)/Double(100)
    guard let result = getUSDFormater().string(from: aDouble as NSNumber) else {
        return ""
    }
    return result
}
