//
//  Person.swift
//  TDDFramework
//
//  Created by Andres Kwan on 6/11/21.
//

import Foundation

//[Workbook] [ch2] - Encapsulate Variable - Refactoring
class Person {
    private(set) var name: String
    
    init(name:String) {
        self.name = name 
    }
}
