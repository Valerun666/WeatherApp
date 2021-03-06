//
//  CurrentWeatherRowViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct CurrentWeatherRowViewModel: Identifiable {
    private let item: CurrentWeatherForecastResponse

    var id: String {
        name
    }

    var name: String {
        item.name
    }

    var temperature: String {
        String(format: "%.1f", item.main.temperature)
    }

    var maxTemperature: String {
        String(format: "%.1f", item.main.maxTemperature)
    }

    var minTemperature: String {
        String(format: "%.1f", item.main.minTemperature)
    }

    var humidity: String {
        String(format: "%.1f", item.main.humidity)
    }

    init(item: CurrentWeatherForecastResponse) {
        self.item = item
    }
}
