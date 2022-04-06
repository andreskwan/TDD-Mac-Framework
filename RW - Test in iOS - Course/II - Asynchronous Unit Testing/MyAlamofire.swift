//
// Created by Andres Kwan on 6/04/22.
//

import Foundation

///
/// The goal of this file is to demostrate how to create an adapter to decouple a dependency from the application
///
class MyAlomofire {
    func taskDownload(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}

extension MyAlomofire: HTTPSession {
    func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return taskDownload(with: with, completionHandler: completionHandler)
    }
}
