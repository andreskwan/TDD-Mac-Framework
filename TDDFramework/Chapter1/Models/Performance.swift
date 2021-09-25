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
    
    /*What is the problem with this code?
     - is it to specific?
    
     */
    var amount: Int?
    
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
