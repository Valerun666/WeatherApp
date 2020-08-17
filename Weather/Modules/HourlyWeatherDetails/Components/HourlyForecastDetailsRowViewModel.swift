//
//  HourlyForecastDetailsRowViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyForecastDetailsRowViewModel: Identifiable {
    let item: HourlyForecast

    var id: String {
        time
    }

    var time: String {
        let date = Date(timeIntervalSince1970: TimeInterval(item.time))
        return date.stringIn(format: Date.DateFormat.hourlyDate.value)
    }

    var temperature: String {
        String(format: "%.1f", item.temperature)
    }

    var feelsLike: String {
        String(format: "%.1f", item.feelsLike)
    }

    var humidity: String {
        String(format: "%.1f", item.humidity)
    }

    var windSpeed: String {
        String(format: "%.2f", item.windSpeed)
    }

    var weather: String {
        item.weather.first?.weatherDescription ?? ""
    }


    init(item: HourlyForecast) {
        self.item = item
    }
}
