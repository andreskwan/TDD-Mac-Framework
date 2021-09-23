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
    let performances: [Performance]
}

// MARK: - Performance
struct Performance: Codable {
    let playID: String
    let audience: Int
    //I enriched the performance by adding the Play
    //it is optional because the API doesn't provide this field
    //so this prevents the app form being breaked 
    var play: Play?
    var amount: Int?
    var volumeCredits: Double?
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
}

class Cost {
    
    func statement(invoice: Invoice, plays: [Play]) -> String {
        func volumeCreditsFor(_ aPerformance: Performance) -> Double {
            var result = 0.0
            // add volume credits
            result += Double(max(aPerformance.audience - 30, 0))
            
            // add extra credit for every ten comedy attendees
            if ("comedy" == aPerformance.play?.type) {
                let value = floor(Double(aPerformance.audience) / 5)
                result += value
            }
            return result
        }
        
        func amountFor(_ aPerformance: Performance) -> Int {
            var result = 0
            guard let type = aPerformance.play?.type else { return result }
            switch type {
            case "tragedy":
                result = 40000
                if (aPerformance.audience > 30) {
                    result += 1000 * (aPerformance.audience - 30)
                }
                break
            case "comedy":
                result = 30000
                if (aPerformance.audience > 20) {
                    result += 1000 * (aPerformance.audience - 20)
                }
                break
            default:
                fatalError("Unknown type: \(String(describing: aPerformance.play?.type))")
            }
            return result
        }
        
        func playFor(_ aPerformance: Performance) -> Play? {
            return plays.first(where: { $0.playID == aPerformance.playID})
        }
        
        func enrichPerformance(_ aPerformance: Performance) -> Performance {
            var tempPerformance = aPerformance
            tempPerformance.play = playFor(aPerformance)
            //amoutFor needs as parameter the tempPerformance which have the play not nil
            tempPerformance.amount = amountFor(tempPerformance)
            tempPerformance.volumeCredits = volumeCreditsFor(tempPerformance)
            return tempPerformance
        }
        
        let statementData = Statement(customer: invoice.customer,
                                      performances: invoice.performances.compactMap(enrichPerformance))
        
        return renderPlainText(data: statementData, invoice: invoice, plays: plays)
    }
    
    func renderPlainText(data: Statement, invoice: Invoice, plays: [Play]) -> String {
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
        
        func totalVolumeCredits() -> Double {
            var result = 0.0
            for aPerformance in data.performances {
                guard let volumeCredits = aPerformance.volumeCredits else { break }
                result += volumeCredits
            }
            return result
        }
        
        func totalAmount() -> Int {
            var result = 0
            for aPerformance in data.performances {
                guard let amount = aPerformance.amount else { break }
                result += amount;
            }
            return result
        }
        
        var result = "Statement for \(data.customer)\n";
        
        for aPerformance in data.performances {
            // print line for this order
            guard let name = aPerformance.play?.name else { break }
            guard let amount = aPerformance.amount else { break }
            result += "  \(name): \(usd(amount)) (\(aPerformance.audience) seats)\n"
        }
        
        result += "Amount owed is \(usd(totalAmount()))\n";
        result += "You earned \(Int(totalVolumeCredits())) credits\n";
        return result;
    }
}

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */
