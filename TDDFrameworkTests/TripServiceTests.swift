//
//  TripServiceTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 21/03/22.
//
//

import XCTest

public struct Trip: Equatable {
}

class UserSession {
    class func getInstance() -> UserSession {
        return UserSession()
    }

    func getLoggerUser() -> User? {
        fatalError("getLoggerUser(_:) has not been implemented")
    }
}

class TripDAO {
    class func findTripsByUser(_ user: User) -> Array<Trip> {
        fatalError("findTripsByUser(_:) has not been implemented")
    }
}

enum UserError: Error {
    case notLoggedIn
}

public struct User: Equatable {
    var friends: Array<User>

    func getFriends() -> Array<User> {
        return friends
    }
}

class TripService {
    public func getTripsBy(user: User?) throws -> Array<Trip> {
        var tripList = Array<Trip>()
        let loggedUser = loggedInUser()
        var isFriend = false

            if (loggedUser != nil) {
                if let user = user {
                    for friend in user.getFriends() {
                        if friend == loggedUser {
                            isFriend = true
                            break
                        }
                    }
                    if isFriend {
                        tripList = TripDAO.findTripsByUser(user)
                    }
                    return tripList
                }
                return []
            } else {
                throw UserError.notLoggedIn
            }
    }

    func loggedInUser() -> User? {
        return UserSession.getInstance().getLoggerUser()
    }
}



class TripServiceTests: XCTestCase {
    var loggedUser: User?
    let guest: User? = nil
    let anyUser: User? = User(friends: [])
    let friend: User? = User(friends: [])
    let registeredUser: User? = User(friends: [])

    func test_getTripsByUser_throws_when_UserNotLoggedIn() {
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

    class TestableTripService: TripService {
        var loggedUser: User?

        override func loggedInUser() -> User? {
            return loggedUser
        }
    }
}
