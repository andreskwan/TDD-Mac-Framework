//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

class TripService {
    public func getTripsBy(user: User?) throws -> Array<Trip> {
        var tripList = Array<Trip>()
        let loggedUser = loggedInUser()
        var isFriend = false

        if let loggedUser = loggedUser {
            if let user = user {
                isFriend = user.isFriend(with: loggedUser)
                if isFriend {
                    tripList = tripsBy(user: user)
                }
                return tripList
            }
            return []
        } else {
            throw UserError.notLoggedIn
        }

    }

    public func tripsBy(user: User) -> [Trip] {
        TripDAO.findTripsByUser(user)
    }

    func loggedInUser() -> User? {
        return UserSession.getInstance().getLoggerUser()
    }
}
