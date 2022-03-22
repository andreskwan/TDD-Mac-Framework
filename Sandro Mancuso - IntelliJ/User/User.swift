//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

enum UserError: Error {
    case notLoggedIn
}

public struct User: Equatable {
    var friends: Array<User>

    func getFriends() -> Array<User> {
        return friends
    }
}