//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

class TripService {
    public func getTripsBy(user: User?) throws -> Array<Trip> {

        guard let loggedInUser = loggedInUser() else {
            throw UserError.notLoggedIn
        }
        guard let user = user,
              user.isFriend(with: loggedInUser)
                else { return [] }
        return tripsBy(user: user)
    }

    public func tripsBy(user: User) -> [Trip] {
        TripDAO.findTripsByUser(user)
    }

    func loggedInUser() -> User? {
        return UserSession.getInstance().getLoggerUser()
    }
}
