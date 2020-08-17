//
//  HourlyWeatherForecastModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherForecastModel {
    let city: String
    let lat: Double
    let lon: Double
    let forecast: [HourlyForecast]
}
