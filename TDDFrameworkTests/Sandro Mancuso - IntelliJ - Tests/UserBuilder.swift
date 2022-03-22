//
// Created by Andres Kwan on 22/03/22.
//

import Foundation
@testable import TDDFramework

class UserBuilder {

    private var friends: [User] = []
    private var trips: [Trip] = []

    private init() {

    }

    static func aUser() -> UserBuilder {
        UserBuilder()
    }

    func friendsWith(_ users: User...) -> UserBuilder {
        friends = users
        return self
    }

    func withTripsTo(_ trips: Trip...) -> UserBuilder {
        self.trips = trips
        return self
    }

    func build() -> User {
        var user = User()
        friends.map { friend in user.addFriend(friend) }
        trips.map { trip in user.addTrip(trip) }
        return user
    }
}
