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
}

// MARK: - Plays
struct Plays: Codable {
    let plays: [Play]
}

// MARK: - Play
struct Play: Codable {
    let playID, name, type: String
}

class Cost {
        
    func statement(invoice: Invoice, plays: [Play]) -> String {
        /* Nesting the extracted function
         - This is helpful as it means I don't have to pass data that's inside the scope of the containing function to the newly extracted function.
         - all the extracted nested functions turn statement into a class?
         */
        func playFor(_ aPerformance: Performance) -> Play? {
            return plays.first(where: { $0.playID == aPerformance.playID})
        }
        
        func amountFor(_ aPerformance: Performance) -> Int {
            var result = 0
            let play = playFor(aPerformance)
            switch play?.type {
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
                fatalError("Unknown type: \(String(describing: play?.type))")
            }
            return result
        }

        var totalAmount = 0
        var volumeCredits = 0.0
        var result = "Statement for \(invoice.customer)\n";
        //          const format = new Intl.NumberFormat("en-US",
        //                                { style: "currency", currency: "USD",
        //                                  minimumFractionDigits: 2 }).format;
        
        for performance in invoice.performances {
            let thisAmount = amountFor(performance)
            
            // add volume credits
            volumeCredits += Double(max(performance.audience - 30, 0))
            
            // add extra credit for every ten comedy attendees
            if ("comedy" == playFor(performance)?.type) {
                let value = floor(Double(performance.audience) / 5)
                volumeCredits += value
            }
            
            // print line for this order
            result += "  \(String(describing: playFor(performance)!.name)): $\(thisAmount/100) (\(performance.audience) seats)\n"
            totalAmount += thisAmount;
        }
//        result += "Amount owed is ${format(totalAmount/100)}\n";
        result += "Amount owed is \(totalAmount/100)\n";
        result += "You earned \(Int(volumeCredits)) credits\n";
        return result;
    }
}

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */
