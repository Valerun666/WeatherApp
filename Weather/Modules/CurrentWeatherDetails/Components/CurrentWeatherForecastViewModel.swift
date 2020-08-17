//
//  CurrentWeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct CurrentWeatherForecastViewModel: Identifiable {
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

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: item.coord.lat, longitude: item.coord.lon)
    }

    init(item: CurrentWeatherForecastResponse) {
        self.item = item
    }
}
