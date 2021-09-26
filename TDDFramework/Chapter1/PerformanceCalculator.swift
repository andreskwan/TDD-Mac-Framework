//
//  PerformanceCalculator.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

class PerformanceCalculator {
    private(set) var aPerformance: Performance!
    
    init(_ aPerformance: Performance, _ aPlay: Play?) {
        self.aPerformance = aPerformance
        self.aPerformance.play = aPlay
    }
    
    var play: Play? {
        return aPerformance.play
    }
    
    func amount() -> Int {
        fatalError("should be calculated by a subclass")
    }
    
    func volumeCredits() -> Double {
        var result = 0.0
        // add volume credits
        result += Double(max(aPerformance.audience - 30, 0))
        
        // add extra credit for every ten comedy attendees
        if ("comedy" == play?.type) {
            let value = floor(Double(aPerformance.audience) / 5)
            result += value
        }
        return result
    }
}

class TragedyCalculator: PerformanceCalculator {
    override func amount() -> Int {
        var result = 40000
        if (aPerformance.audience > 30) {
            result += 1000 * (aPerformance.audience - 30)
        }
        return result
    }
}

class ComedyCalculator: PerformanceCalculator {
    override func amount() -> Int {
        var result = 30000
        if (aPerformance.audience > 20) {
            result += 1000 * (aPerformance.audience - 20)
        }
        return result
    }
}
