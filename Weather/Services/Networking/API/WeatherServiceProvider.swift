//
//  WeatherServiceProvider.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

enum WeatherServiceProvider: Provider {
    case currentWeather(cityId: String)
    case hourlyForecast(lat: String, lon: String)

    private struct Constants {
        static let key = "e3b937fe38389d72e4611c5613c8b272"
    }

    var route: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        case .hourlyForecast:
            return "/data/2.5/onecall"
        }
    }

    var params: [NetworkParam] {
        switch self {
        case .currentWeather(let cityId):
            return [NetworkParam(name: "q", value: cityId),
                    NetworkParam(name: "mode", value: "json"),
                    NetworkParam(name: "units", value: "metric"),
                    NetworkParam(name: "APPID", value: Constants.key)]
        case .hourlyForecast(let lat, let lon):
            return [NetworkParam(name: "lat", value: lat),
                    NetworkParam(name: "lon", value: lon),
                    NetworkParam(name: "mode", value: "json"),
                    NetworkParam(name: "units", value: "metric"),
                    NetworkParam(name: "exclude", value: "minutely,daily,current"),
                    NetworkParam(name: "appid", value: Constants.key)]
        }
    }
}
