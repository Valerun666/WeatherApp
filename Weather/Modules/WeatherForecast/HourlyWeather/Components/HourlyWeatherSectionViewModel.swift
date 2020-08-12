//
//  HourlyWeatherSectionViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherSectionViewModel {
    let city: String
    let hourlyForecast: [HourlyWeatherRowViewModel]

    init(item: HourlyWeatherForecastModel) {
        self.city = item.city.name
        self.hourlyForecast = item.forecast.map(HourlyWeatherRowViewModel.init(item: ))
    }

}
