//
//  AsyncNetworkCalls.swift
//  TDD-Katas-MacOSTests
//
//  Created by Andres Kwan on 22/08/21.
//
//more api to test
//read the post https://developer.apple.com/forums/thread/116124
//https://docs.mhw-db.com
//https://github.com/LartTyler/MHWDB-API
//https://developers.themoviedb.org/3/getting-started/introduction

import XCTest
@testable import TDDFramework

final class AsyncNetworkCallsTests: XCTestCase {
    let timeout: TimeInterval = 2
    var expectation: XCTestExpectation!
    
    override func setUp() {
        expectation = expectation(description: "Server responds in reasonable time")
    }
    
    func test_noServerResponse() {
        let url = URL(string: "invalidURL")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill()
                print("2) in defer block, must be called at the end of the complition")
            }
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            print("1) must be printed before the defer block is called")
        }
        .resume()
        
        waitForExpectations(timeout: timeout)
    }
    
//    func test_decodeData() {
//        let url = getValidUrl()
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            defer { self.expectation.fulfill() }
//            
//            XCTAssertNil(error)
//            
//            do {
//                let response = try XCTUnwrap(response as? HTTPURLResponse)
//                XCTAssertEqual(response.statusCode, 200)
//                let data = try XCTUnwrap(data)
//                print(String(decoding: data, as: UTF8.self))
//                XCTAssertNoThrow(
//                    try JSONDecoder().decode(Quotes.self, from: data)
//                )
//            }
//            catch { }
//        }.resume()
//        
//        waitForExpectations(timeout: timeout)
//    }
    
    ///this test is not testing for 404 data
    ///it is usefult to validate the errors while decoding data
    func test_requestWithResponse404_shouldThrowError_ifDecodingAQuote() {
        //given
        let url = get404WithUrl()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            
            XCTAssertNil(error)
            
            do {
                let response = try XCTUnwrap(response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 404)
                
                let data = try XCTUnwrap(data)
                print(String(decoding: data, as: UTF8.self))
                
                //it should throw error, because it returned JSON data representing the error not a quote
                //it should decode an error not a quote
                _ = try JSONDecoder().decode(Quotes.self, from: data)
            }
            catch {
                switch error {
                case DecodingError.typeMismatch:
                    print("\(error)")
                case DecodingError.dataCorrupted:
                    print("\(error)")
                case DecodingError.keyNotFound(let key, _):
                    print("Error -------: \(error)")
                    print("Key -------: \(key)")
                default:
                    print("default-Error -------: \(error)")
                    XCTFail("\(error)")
                }
            }
        }
        .resume()
        
        waitForExpectations(timeout: timeout)
    }
    
//    commented because the setUp() is setting the expectation for this test
//    but that expectation is not being waited
//    func test_apiClient() {
//
//    }
    
    //MARK: Helpers
    fileprivate func getValidUrl() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "quotes.rest"
        components.path = "/qod.json"
        
        let queryItem = URLQueryItem(name: "category", value: "inspire")
        components.queryItems = [queryItem]
        return components.url!
    }

    fileprivate func get404WithUrl() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "quotes.rest"
        components.path = "/pod.json"
        
        let queryItem = URLQueryItem(name: "category", value: "inspire")
        components.queryItems = [queryItem]
        return components.url!
    }
}
