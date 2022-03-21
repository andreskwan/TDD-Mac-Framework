//
//  TripServiceTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 21/03/22.
//
//

import XCTest

public struct Trip {
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
    private var friends: Array<User>

    func getFriends() -> Array<User> {
        return friends
    }
}

class TripService {
    public func getTripsBy(user: User) throws -> Array<Trip> {
        var tripList = Array<Trip>()
        let loggedUser = UserSession.getInstance().getLoggerUser()
        var isFriend = false
        if (loggedUser != nil) {
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
        } else {
            throw UserError.notLoggedIn
        }
    }
}

class TripServiceTests: XCTestCase {

}
