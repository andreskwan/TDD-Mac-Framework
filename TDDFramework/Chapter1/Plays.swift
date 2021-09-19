//
//  Plays.swift
//  TDDFramework
//
//  Created by Andres Kwan on 19/09/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let invoices = try? newJSONDecoder().decode(Invoices.self, from: jsonData)

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
        var totalAmount = 0
        var volumeCredits = 0.0
        var result = "Statement for \(invoice.customer)\n";
        //          const format = new Intl.NumberFormat("en-US",
        //                                { style: "currency", currency: "USD",
        //                                  minimumFractionDigits: 2 }).format;
        
        for performance in invoice.performances {
            let play = plays.first(where: { $0.playID == performance.playID})
            var thisAmount = 0
            
            switch play?.type {
            case "tragedy":
                thisAmount = 40000
                if (performance.audience > 30) {
                    thisAmount += 1000 * (performance.audience - 30)
                }
                break
            case "comedy":
                thisAmount = 30000
                if (performance.audience > 20) {
                    thisAmount += 1000 * (performance.audience - 20)
                }
                break
            default:
                fatalError("Unknown type: \(String(describing: play?.type))")
            }
            
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
