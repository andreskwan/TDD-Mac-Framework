//
//  TripServiceTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 21/03/22.
//
//

import XCTest

class TripService {
    public func getTripsBy(user: User) throws -> Arrat<Trips> {
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
