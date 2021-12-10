//
//  MatchTest.swift
//  TDDFrameworkTests
//
//  Created by Andres Kwan on 10/12/21.
//

import XCTest

class MatchTest: XCTestCase {

    func test_Match () {
        let matcher = Matcher()
        let expected: [Int] = [10, 50, 30, 98]
        let clipLimit = 100
        let delta = 5
        
        var actual:[Int] = [12, 55, 25, 110] //[12, 55, 25, 100]
        XCTAssertTrue( matcher.match(expected, &actual, clipLimit, delta) )
        
        actual = [10, 60, 30, 98]
        XCTAssertTrue(!matcher.match(expected, &actual, clipLimit, delta))
        
        actual = [10, 50, 30]
        XCTAssertTrue(!matcher.match(expected, &actual, clipLimit, delta))
    }
}

public class Matcher {
//    init (){}
    
    fileprivate func clip(_ actual: [Int], _ clipLimit: Int) -> [Int] {
        var result = actual
        // Clip "too-large" values
        for i in 0...result.count-1{
            if (result[i] > clipLimit) {
                result[i] = clipLimit;
            }
        }
        return result
    }
    
    public func match(_ expected: [Int], _ actual: inout [Int], _ clipLimit: Int, _ delta: Int) -> Bool {
        
        let cliped = clip(actual, clipLimit)
        
        // Check for length differences
        if (cliped.count != expected.count){
            return false
        }
        
        // Check that each entry within expected +/- delta
        for i in 0...cliped.count-1{
            if (abs(expected[i] - cliped[i]) > delta) {
                return false
            }
        }
        
        return true
    }
}
