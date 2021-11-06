//
//  Person.swift
//  TDDFramework
//
//  Created by Andres Kwan on 6/11/21.
//

import Foundation

//[Workbook] [ch2] - Encapsulate Variable - Refactoring
/// questions?
/// this prevents the smell global data?
/// is this an smell
/// how to make it evident?
/// is there an example of replacing a variable with a function?
class Person {
    private(set) var name: String
    
    init(name:String) {
        self.name = name
    }
}
