//
//  Settings.swift
//  RaceGame
//
//  Created by Roman Dod on 10/21/20.
//  Copyright © 2020 Roman Dod. All rights reserved.
//

import Foundation

struct Settings: Codable {
    let speed: Int
    let color: String
    let name: String
}

private enum CodingKeys: String, CodingKey {
    case speed
    case color
    case name
}

