//
// Created by Andres Kwan on 22/03/22.
//

import Foundation

class UserSession {
    class func getInstance() -> UserSession {
        return UserSession()
    }

    func getLoggerUser() -> User? {
        fatalError("getLoggerUser(_:) has not been implemented")
    }
}