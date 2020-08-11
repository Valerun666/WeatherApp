//
//  CurrentWeatherForecastResponse.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct CurrentWeatherForecastResponse: Decodable {
    let coord: Coord
    let main: Main
    let name: String

    struct Main: Codable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
}
