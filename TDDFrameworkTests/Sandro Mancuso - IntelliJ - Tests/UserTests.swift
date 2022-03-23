//
//  Test.swift
//  TDDFramework
//
//  Created by Andres Kwan on 22/03/22.
//
//

import XCTest
@testable import TDDFramework

class UserTests: XCTestCase {

    func test_isFriendWith_inform_when_friends_with_another_user() {
        let paul = User()
        let joe = User()
        var user = UserBuilder.aUser().friendsWith(paul).build()

        XCTAssertTrue(user.isFriend(with: paul))
        XCTAssertFalse(user.isFriend(with: joe), "users should not be friends")
    }
}
