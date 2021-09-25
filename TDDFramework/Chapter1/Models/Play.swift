//
//  Play.swift
//  TDDFramework
//
//  Created by Andres Kwan on 25/09/21.
//

import Foundation

// MARK: - Plays
struct Plays: Codable {
    let plays: [Play]
}

// MARK: - Play
struct Play: Codable {
    let playID, name, type: String
}
