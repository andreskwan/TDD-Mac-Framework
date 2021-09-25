//
//  PerformanceCalculator.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

class PerformanceCalculator {
    private var performance: Performance!
    private(set) var play: Play?
    
    init(aPerformance: Performance, aPlay: Play?) {
        self.performance = aPerformance
        self.play = aPlay
    }
}
