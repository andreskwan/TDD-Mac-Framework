//
//  Plays.swift
//  TDDFramework
//
//  Created by Andres Kwan on 19/09/21.
//

import Foundation

// MARK: - Invoices
struct Invoices: Codable {
    let invoices: [Invoice]
}

// MARK: - Invoice
struct Invoice: Codable {
    let customer: String
    var performances: [Performance]
    
    //experimenting
    var plays: [Play]?
    var totalAmount: Int {
        return performances.reduce(0){$0 + $1.amount}
    }
    var totalVolumeCredits: Double {
        return performances.reduce(0.0){$0 + $1.volumeCredits}
    }
}

// MARK: - Performance
struct Performance: Codable {
    let playID: String
    let audience: Int
    
    //experimenting
    //I enriched the performance by adding the Play
    //it is optional because the API doesn't provide this field
    //so this prevents the app form being breaked 
    var play: Play?
    var amount: Int {
        var result = 0
        guard let type = play?.type else { return result }
        switch type {
        case "tragedy":
            result = 40000
            if (audience > 30) {
                result += 1000 * (audience - 30)
            }
            break
        case "comedy":
            result = 30000
            if (audience > 20) {
                result += 1000 * (audience - 20)
            }
            break
        default:
            fatalError("Unknown type: \(String(describing: play?.type))")
        }
        return result
    }
    var volumeCredits: Double {
        var result = 0.0
        // add volume credits
        result += Double(max(audience - 30, 0))
        
        // add extra credit for every ten comedy attendees
        if ("comedy" == play?.type) {
            let value = floor(Double(audience) / 5)
            result += value
        }
        return result
    }
}

// MARK: - Plays
struct Plays: Codable {
    let plays: [Play]
}

// MARK: - Play
struct Play: Codable {
    let playID, name, type: String
}

struct Statement {
    let customer: String
    let performances: [Performance] //is this data inmutable/copied or does it reference to the same array? let guranties that is inmutable.
    let totalAmount: Double
    let totalVolumeCredits: Int
}

func enricheInvoce(_ aInvoice: Invoice, _ plays: [Play]) -> Invoice {
    func playFor(_ aPerformance: Performance, _ plays: [Play]) -> Play? {
        return plays.first(where: { $0.playID == aPerformance.playID})
    }
    
    func enrichPerformance(_ aPerformance: Performance, _ plays: [Play]) -> Performance {
        var tempPerformance = aPerformance
        tempPerformance.play = playFor(aPerformance, plays)
        return tempPerformance
    }
    
    var result = aInvoice
    result.plays = plays
    result.performances = result.performances.map{ enrichPerformance($0, plays) }
    return result
}

class Cost {
    
    func statement(invoice: Invoice, plays: [Play]) -> String {
        return renderPlainText(invoice: enricheInvoce(invoice, plays))
    }
    
    func renderPlainText(invoice: Invoice) -> String {
        /* Nesting the extracted function
         - This is helpful as it means I don't have to pass data that's inside the scope of the containing function to the newly extracted function.
         - all the extracted nested functions turn statement into a class?
         */
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
        
        var result = "Statement for \(invoice.customer)\n";
        
        for aPerformance in invoice.performances {
            guard let name = aPerformance.play?.name else { break }
            result += "  \(name): \(usd(aPerformance.amount)) (\(aPerformance.audience) seats)\n"
        }
        
        result += "Amount owed is \(usd(invoice.totalAmount))\n";
        result += "You earned \(Int(invoice.totalVolumeCredits)) credits\n";
        return result;
    }
}

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */
