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
    let anyUserWithoutFriends: User? = User(friends: [])

    func test_getTripsByUser_throws_when_userIsNotLoggedIn() {
        let sut = TestableTripService()
        sut.loggedUser = guest
        let user: User? = nil

        XCTAssertThrowsError(try sut.getTripsBy(user: user)) { error in
            XCTAssertEqual(error as! UserError, UserError.notLoggedIn)
        }
    }

    func test_getTripsByUser_returns_emptyFriends_ifUserIsNil() {
        let sut = TestableTripService()
        sut.loggedUser = anyUserWithoutFriends
        let user: User? = nil

        let noTrips: Array<Trip> = []
        do {
            let trips = try sut.getTripsBy(user: user)
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
