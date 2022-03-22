//
//  TripServiceTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 21/03/22.
//
//

import XCTest
@testable import TDDFramework

class TripServiceTests: XCTestCase {
    private var loggedUser: User?
    private let guest: User? = nil
    private let anyUser: User? = User(friends: [])
    private lazy var friend: User? = User(friends: [loggedUser!])
    private let registeredUser: User? = User(friends: [])
    private let stranger = User(friends: [])

    func test_getTripsByUser_validates_theLoggedInUser_throws_when_UserNotLoggedIn() {
        let sut = TestableTripService()
        sut.loggedUser = guest

        XCTAssertThrowsError(try sut.getTripsBy(user: anyUser)) { error in
            XCTAssertEqual(error as! UserError, UserError.notLoggedIn)
        }
    }

    func test_getTripsByUser_returns_emptyTrips_ifNoUserProvided() {
        let sut = TestableTripService()
        sut.loggedUser = registeredUser
        let noUser: User? = nil

        let noTrips: Array<Trip> = []
        do {
            let trips = try sut.getTripsBy(user: noUser)
            XCTAssertEqual(trips, noTrips)
        } catch {
            XCTFail()
        }
    }

    func test_getTripsByUser_returns_noTrips_when_usersAreNotFriends() {
        let sut = TestableTripService()
        sut.loggedUser = registeredUser

        let noTrips: Array<Trip> = []
        do {
            let trips = try sut.getTripsBy(user: stranger)
            XCTAssertEqual(trips, noTrips)
        } catch {
            XCTFail()
        }
    }

    class TestableTripService: TripService {
        var loggedUser: User?

        override func loggedInUser() -> User? {
            return loggedUser
        }
    }
}
