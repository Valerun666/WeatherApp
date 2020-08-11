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
        String(item.timeTxt)
    }

    var temperature: String {
        String(item.temperature.temp)
    }

    init(item: HourlyForecast) {
        self.item = item
    }

}
