//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

enum UserError: Error {
    case notLoggedIn
}

public struct User: Equatable {
    private var friends: Array<User> = []
    private var trips: Array<Trip> = []
    let uuid: UUID = UUID()

    func getFriends() -> Array<User> {
        return friends
    }

    mutating func addFriend(_ user: User) {
        friends.append(user)
    }

    mutating func addTrip(_ trip: Trip) {
        trips.append(trip)
    }

    func getTrips() -> Array<Trip> {
        return trips
    }

    public func isFriend(with anotherUser: User) -> Bool {
        (friends.first(where: { $0 == anotherUser }) != nil)
    }
}