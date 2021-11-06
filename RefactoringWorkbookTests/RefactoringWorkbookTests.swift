//
//  RefactoringWorkbookTests.swift
//  RefactoringWorkbookTests
//
//  Created by Andres Kwan on 6/11/21.
//

import XCTest
@testable import TDDFramework

class RefactoringWorkbookTests: XCTestCase {

    //characterization test
    func test() {
        let person = Person()
        person.name = "Bob Smith"
        XCTAssertEqual("Bob Smith", person.name)
    }

}
