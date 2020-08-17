//
//  HourlyWeatherSectionViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherSectionViewModel {
    let timeZone: String
    let hourlyForecast: [HourlyWeatherRowViewModel]

    init(item: HourlyWeatherForecastResponse) {
        self.timeZone = item.timezone.replacingOccurrences(of: "_", with: " ")
        self.hourlyForecast = item.forecast.map(HourlyWeatherRowViewModel.init(item: ))
    }
}
