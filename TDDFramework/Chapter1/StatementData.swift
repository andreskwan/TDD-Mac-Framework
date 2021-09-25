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
    
    static func enrichPerformance(_ aPerformance: Performance, _ plays: [Play]) -> Performance {
        func playFor(_ aPerformance: Performance, _ plays: [Play]) -> Play? {
            return plays.first(where: { $0.playID == aPerformance.playID})
        }
        let calculator = PerformanceCalculator(aPerformance: aPerformance, aPlay: playFor(aPerformance, plays))
        var tempPerformance = aPerformance
        tempPerformance.play = calculator.play
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
