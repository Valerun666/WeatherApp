//
//  HourlyWeatherForecastResponse.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherForecastResponse: Codable {
    let forecasts: [HourlyForecast]
    let city: City

    enum CodingKeys: String, CodingKey {
        case forecasts = "list"
        case city
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let sunrise: Int
    let sunset: Int

    struct Coord: Codable {
        let lat, lon: Double
    }
}

struct HourlyForecast: Codable {
    let time: Int
    let temperature: HourlyTemperature
    let weather: [Weather]
    let timeTxt: String

    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case timeTxt = "dt_txt"
        case temperature = "main"
        case weather
    }
}

struct HourlyTemperature: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

