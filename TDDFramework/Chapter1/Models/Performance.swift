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
    var amount: Int?
    var volumeCredits: Double?
}
