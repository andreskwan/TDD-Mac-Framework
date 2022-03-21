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

    func getLoggerUser() -> User {
        fatalError("getLoggerUser(_:) has not been implemented")
    }
}

class TripDAO {
    class func findTripsByUser(_ user: User) -> Array<Trip> {
        fatalError("findTripsByUser(_:) has not been implemented")
    }
}

class UserNotLoggedInException: Error {
}

public struct User {
    private var friends: Array<User>

    func getFriends() -> Array<User> {
        return friends
    }
}

class TripService {
    public func getTripsBy(user: User) throws -> Array<Trip> {
        var tripList = Array<Trip>()
        let loggedUser = UserSession.getInstance().getLoggerUser()
        let isFriend = false
        if (loggedUser != nil) {
            for user in user.getFriends() {
                if friend.equals(loggedUser) {
                    isFriend = true
                    break
                }
            }
            if isFriend {
                tripList = TripDAO.findTripsByUser(user)
            }
            return tripList
        } else {
            throw UserNotLoggedInException()
        }
    }
}

class TripServiceTests: XCTestCase {

}
