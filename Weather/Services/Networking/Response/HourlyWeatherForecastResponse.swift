//
//  HourlyWeatherForecastResponse.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherForecastResponse: Codable {
    let forecast: [HourlyForecast]
    let lat: Double
    let lon: Double
    let timezone: String
    
    enum CodingKeys: String, CodingKey {
        case forecast = "hourly"
        case lat, lon
        case timezone
    }
}


struct HourlyForecast: Codable {
    let time: Int
    let temperature: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case feelsLike = "feels_like"
        case pressure, humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
        case temperature = "temp"
    }
}

struct Weather: Codable {
    let main: String
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}
