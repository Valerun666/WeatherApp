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
    case hourlyForecast(cityId: String)

    private struct Constants {
        static let key = "fcd342ac34b4b3f27c62197b86372fce"
    }

    var route: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        case .hourlyForecast:
            return "/data/2.5/hourly"
        }
    }

    var params: [NetworkParam] {
        switch self {
        case .currentWeather(let cityId), .hourlyForecast(let cityId):
            return [NetworkParam(name: "q", value: cityId),
                    NetworkParam(name: "mode", value: "json"),
                    NetworkParam(name: "units", value: "metric"),
                    NetworkParam(name: "APPID", value: Constants.key)]
        }
    }
}
