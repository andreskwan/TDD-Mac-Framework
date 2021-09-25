//
//  Performance.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

// MARK: - Performance
struct Performance: Codable {
    let playID: String
    let audience: Int
    
    //experimenting
    //I enriched the performance by adding the Play
    //it is optional because the API doesn't provide this field
    //so this prevents the app form being breaked
    var play: Play?
    
    //this code is to specific
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
