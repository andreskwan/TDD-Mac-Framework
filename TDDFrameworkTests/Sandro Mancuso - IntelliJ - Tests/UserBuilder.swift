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
        addFriendsTo(&user)
        addTripsTo(&user)
        return user
    }

    private func addTripsTo(_ user: inout User) -> [()] {
        trips.map { trip in user.addTrip(trip) }
    }

    private func addFriendsTo(_ user: inout User) -> [()] {
        friends.map { friend in user.addFriend(friend) }
    }
}
