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
    
    fileprivate func getAmountPerPerformance(_ play: Play?, _ performance: Performance) -> Int {
        var result = 0
        switch play?.type {
        case "tragedy":
            result = 40000
            if (performance.audience > 30) {
                result += 1000 * (performance.audience - 30)
            }
            break
        case "comedy":
            result = 30000
            if (performance.audience > 20) {
                result += 1000 * (performance.audience - 20)
            }
            break
        default:
            fatalError("Unknown type: \(String(describing: play?.type))")
        }
        return result
    }
    
    func statement(invoice: Invoice, plays: [Play]) -> String {
        var totalAmount = 0
        var volumeCredits = 0.0
        var result = "Statement for \(invoice.customer)\n";
        //          const format = new Intl.NumberFormat("en-US",
        //                                { style: "currency", currency: "USD",
        //                                  minimumFractionDigits: 2 }).format;
        
        for performance in invoice.performances {
            let play = plays.first(where: { $0.playID == performance.playID})
            var thisAmount = 0
            
            thisAmount = getAmountPerPerformance(play, performance)
            
            // add volume credits
            volumeCredits += Double(max(performance.audience - 30, 0))
            
            // add extra credit for every ten comedy attendees
            if ("comedy" == play?.type) {
                let value = floor(Double(performance.audience) / 5)
                volumeCredits += value
            }
            
            // print line for this order
            result += "  \(String(describing: play!.name)): $\(thisAmount/100) (\(performance.audience) seats)\n"
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
