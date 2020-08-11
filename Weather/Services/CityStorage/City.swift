//
//  City.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct City: Codable {
    let name: String
    let lat: Double
    let lon: Double
}

extension City: Identifiable {
    var id: String {
        name
    }
}

extension City: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
}
