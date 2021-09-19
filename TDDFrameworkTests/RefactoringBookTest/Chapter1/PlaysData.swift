//
//  PlaysData.swift
//  TDDFrameworkTests
//
//  Created by Andres Kwan on 19/09/21.
//

import Foundation

//JSON validator https://jsonlint.com

public let playsData = """
{
    "plays": [{
        "playID": "hamlet",
        "name": "Hamlet",
        "type": "tragedy"
    }, {
        "playID": "as-like",
        "name": "As You Like It",
        "type": "comedy"
    }, {
        "playID": "othello",
        "name": "Othello",
        "type": "tragedy"
    }]
}
""".data(using: .utf8)!

let invoicesData = """
{
    "invoices": [{
        "customer": "BigCo",
        "performances": [{
                "playID": "hamlet",
                "audience": 55
            },
            {
                "playID": "as-like",
                "audience": 35
            },
            {
                "playID": "othello",
                "audience": 40
            }
        ]
    }]
}
""".data(using: .utf8)!
