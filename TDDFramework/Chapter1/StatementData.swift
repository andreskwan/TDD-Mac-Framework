//
//  CreateStatementData.swift
//  TDDFramework
//
//  Created by Andres Kwan on 23/09/21.
//

import Foundation

struct StatementData {
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
    
    static func playFor(_ aPerformance: Performance, _ plays: [Play]) -> Play? {
        return plays.first(where: { $0.playID == aPerformance.playID})
    }
    
    static func amountFor(_ aPerformance: Performance) -> Int {
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
    
    static func enrichPerformance(_ aPerformance: Performance, _ plays: [Play]) -> Performance {
        let calculator = PerformanceCalculator(aPerformance: aPerformance, aPlay: playFor(aPerformance, plays))
        var tempPerformance = aPerformance
        tempPerformance.play = calculator.play
        tempPerformance.amount = amountFor(tempPerformance)
        return tempPerformance
    }

    static func enricheInvoice(_ invoice: Invoice, _ plays: [Play]) -> Invoice {
        var result = invoice
        result.performances = invoice.performances.map{ enrichPerformance($0, plays) }
        return result
    }
    
    init(_ invoice: Invoice, _ plays: [Play]) {
        self.invoice = StatementData.enricheInvoice(invoice, plays)
        self.plays = plays
    }
}
