//
//  Models.swift
//  TDDFramework
//
//  Created by Andres Kwan on 23/09/21.
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
        return performances.reduce(0){$0 + ($1.amount ?? 0)}
    }
    var totalVolumeCredits: Double {
        return performances.reduce(0.0){$0 + ($1.volumeCredits ?? 0)}
    }
}
