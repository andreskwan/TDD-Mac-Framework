// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quotes = try? newJSONDecoder().decode(Quotes.self, from: jsonData)

import Foundation

// MARK: - Quotes
struct Quotes: Codable {
    let success: Success
    let contents: Contents
    let baseurl: String
    let copyright: Copyright
}

// MARK: - Contents
struct Contents: Codable {
    let quotes: [Quote]
}

// MARK: - Quote
struct Quote: Codable {
    let length, quote, author: String
    //Decoding the Quote was failing because tags can be an [Strings] or a dictionary!
//    let tags: [String: String]
    let tags: [String]
    let category, language, date: String
    let permalink: String
    let id: String
    let background: String
    let title: String
}

// MARK: - Copyright
struct Copyright: Codable {
    let year: Int
    let url: String
}

// MARK: - Success
struct Success: Codable {
    let total: Int
}

let json404 = """
{
    "error": {
        "code": 404,
        "message": "Not Found"
    }
}
"""

let tagsAsDictionaries = """
    {
    "success": {
        "total": 1
    },
    "contents": {
        "quotes": [
            {
                "quote": "If you don't have confidence, you'll always find a way not to win",
                "length": "65",
                "author": "Carl Lewis",
                "tags": {
                    "0": "confidence",
                    "1": "inspire",
                    "3": "trust",
                    "4": "winning"
                },
                "category": "inspire",
                "language": "en",
                "date": "2021-08-23",
                "permalink": "https://theysaidso.com/quote/carl-lewis-if-you-dont-have-confidence-youll-always-find-a-way-not-to-win",
                "id": "4sjGQiAAZhY6jCxr6XcV1QeF",
                "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
                "title": "Inspiring Quote of the day"
            }
        ]
    },
    "baseurl": "https://theysaidso.com",
    "copyright": {
        "year": 2023,
        "url": "https://theysaidso.com"
    }
}
"""


let tagsAsArrays = """
{
    "success": {
        "total": 1
    },
    "contents": {
        "quotes": [
            {
                "quote": "Somewhere between the bottom of the climb and the summit is the answer to the mystery why we climb.",
                "length": "99",
                "author": "Greg Child",
                "tags": [
                    "inspire",
                    "life",
                    "meaning",
                    "mountaineering"
                ],
                "category": "inspire",
                "language": "en",
                "date": "2021-08-24",
                "permalink": "https://theysaidso.com/quote/greg-child-somewhere-between-the-bottom-of-the-climb-and-the-summit-is-the-answe",
                "id": "4wWSyA_IO87jFwNPKkN7aweF",
                "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
                "title": "Inspiring Quote of the day"
            }
        ]
    },
    "baseurl": "https://theysaidso.com",
    "copyright": {
        "year": 2023,
        "url": "https://theysaidso.com"
    }
}
"""
