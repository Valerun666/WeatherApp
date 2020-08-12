//
//  HourlyWeatherRowViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import SwiftUI

struct HourlyWeatherRowViewModel: Identifiable {
    private let item: HourlyForecast

    var id: Int {
        item.time
    }

    var time: String {
        let date = Date(timeIntervalSince1970: TimeInterval(item.time))
        return date.stringIn(format: Date.DateFormat.hourlyDate.value)
    }

    var temperature: String {
        String(format: "%.1f", item.temperature)
    }

    init(item: HourlyForecast) {
        self.item = item
    }

}
