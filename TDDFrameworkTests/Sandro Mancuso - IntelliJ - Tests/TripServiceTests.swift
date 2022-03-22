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

    private let guest: User? = nil
    private let anyUser: User? = User()
    private let anotherUser: User? = User()
    private let registeredUser: User? = User()

    private let london = Trip()
    private let barcelona = Trip()

    private var sut: TestableTripService!

    override func setUp() {
        super.setUp()
        sut = TestableTripService()
        sut.loggedUser = registeredUser
    }

    func test_getTripsByUser_validates_theLoggedInUser_throws_when_UserNotLoggedIn() {
        sut.loggedUser = guest

        XCTAssertThrowsError(try sut.getTripsBy(user: anyUser)) { error in
            XCTAssertEqual(error as! UserError, UserError.notLoggedIn)
        }
    }

    func test_getTripsByUser_returns_noTrips_ifNoUserProvided() {
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
        let stranger = UserBuilder.aUser()
                .friendsWith(anotherUser!)
                .withTripsTo(london, barcelona)
                .build()

        let noTrips: Array<Trip> = []
        do {
            let trips = try sut.getTripsBy(user: stranger)
            XCTAssertEqual(trips, noTrips)
        } catch {
            XCTFail()
        }
    }

    func test_getTripsByUser_returns_trips_when_usersAreFriends() {
        let friend = UserBuilder.aUser()
                .friendsWith(sut.loggedUser!)
                .withTripsTo(london, barcelona)
                .build()

        let expectedTrips = [london, barcelona]

        do {
            let trips = try sut.getTripsBy(user: friend)
            XCTAssertEqual(trips, expectedTrips)
        } catch {
            XCTFail()
        }
    }

    class TestableTripService: TripService {
        var loggedUser: User?

        override func loggedInUser() -> User? {
            loggedUser
        }

        override func tripsBy(user: User) -> [Trip] {
            user.getTrips()
        }
    }
}
