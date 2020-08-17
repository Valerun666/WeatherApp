//
//  HourlyWeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


struct HourlyWeatherForecastViewModel {
    private let item: HourlyWeatherForecastResponse
    let rows: [HourlyForecastDetailsRowViewModel]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)
    }

    var timezone: String {
        item.timezone
    }

    init(item: HourlyWeatherForecastResponse) {
        self.item = item
        self.rows = item.forecast.map(HourlyForecastDetailsRowViewModel.init(item:))
    }
}
