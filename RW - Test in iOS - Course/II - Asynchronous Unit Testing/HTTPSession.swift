//
// Created by Andres Kwan on 6/04/22.
//

import Foundation

///
/// A better approach would be to use URLProtocol abstract class to test the networking calls
/// - this new metatype wouldn't be needed.
///
protocol HTTPSession {
    func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: HTTPSession {}