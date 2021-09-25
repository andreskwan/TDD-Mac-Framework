//
//  PerformanceCalculator.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

class PerformanceCalculator {
    private var aPerformance: Performance!
    
    init(aPerformance: Performance, aPlay: Play?) {
        self.aPerformance = aPerformance
        self.aPerformance.play = aPlay
    }
    
    var play: Play? {
        return aPerformance.play
    }
    
    func amount() -> Int {
        var result = 0
        guard let play = aPerformance.play else {
            fatalError("the play of the Performance should be set at this level")
        }
        
        switch play.type {
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
            fatalError("Unknown type: \(String(describing: play.type))")
        }
        return result
    }
}
