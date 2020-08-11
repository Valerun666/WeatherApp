//
//  HourlyWeatherSectionViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

struct HourlyWeatherSectionViewModel: Identifiable {
    private let item: HourlyWeatherForecastResponse

    var id: String {
        item.city
    }

    var name: String {
        item.city
    }

    private(set) var hourlyForecast: [HourlyWeatherRowViewModel]

    init(item: HourlyWeatherForecastResponse) {
        self.item = item
        self.hourlyForecast = item.forecasts.map(HourlyWeatherRowViewModel.init(item: ))
    }

}
