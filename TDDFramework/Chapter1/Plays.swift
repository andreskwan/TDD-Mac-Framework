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
    //I enriched the performance by adding the Plays
    //it is optional because the API doesn't provide this field
    //so this prevents the app form being breaked
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
    let invoice: Invoice
    let plays: [Play]
    
    var customer: String {
        return invoice.customer
    }
    
    var totalAmount: Int {
        return invoice.totalAmount
    }
    
    var totalVolumeCredits: Double {
        return invoice.totalVolumeCredits
    }
    
    var performances: [Performance] {
        return invoice.performances
    }
    
    static func enrichPerformance(_ aPerformance: Performance, _ plays: [Play]) -> Performance {
        func playFor(_ aPerformance: Performance, _ plays: [Play]) -> Play? {
            return plays.first(where: { $0.playID == aPerformance.playID})
        }
        
        var tempPerformance = aPerformance
        tempPerformance.play = playFor(aPerformance, plays)
        return tempPerformance
    }

    static func enricheInvoice(_ invoice: Invoice, _ plays: [Play]) -> Invoice {
        var result = invoice
        result.performances = invoice.performances.map{ enrichPerformance($0, plays) }
        return result
    }
    
    init(_ invoice: Invoice, _ plays: [Play]) {
        self.invoice = Statement.enricheInvoice(invoice, plays)
        self.plays = plays
    }
}

class Cost {
    func createStatemen(_ invoice: Invoice, _ plays: [Play]) -> Statement {
        return Statement(invoice, plays)
    }
    
    func statement(invoice: Invoice, plays: [Play]) -> String {
        return renderPlainText(createStatemen(invoice, plays))
    }
    
    func renderPlainText(_ statement: Statement) -> String {
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
        
        var result = "Statement for \(statement.customer)\n";
        
        for aPerformance in statement.performances {
            guard let name = aPerformance.play?.name else { break }
            result += "  \(name): \(usd(aPerformance.amount)) (\(aPerformance.audience) seats)\n"
        }
        
        result += "Amount owed is \(usd(statement.totalAmount))\n";
        result += "You earned \(Int(statement.totalVolumeCredits)) credits\n";
        return result;
    }
}

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */
