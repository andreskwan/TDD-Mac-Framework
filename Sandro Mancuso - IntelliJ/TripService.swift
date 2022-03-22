//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

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
