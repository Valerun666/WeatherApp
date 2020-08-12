//
//  HourlyWeatherRouter.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 12.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class HourlyWeatherRouter: HourlyWeatherRouterOutput {
    @Published var hourlyWeatherDetails: AnyView = .init(EmptyView())
}

extension HourlyWeatherRouter: HourlyWeatherRouterInput {
    func showHourlyWeatherDetails() {
        hourlyWeatherDetails = AnyView(Text("HourlyWeatherDetails"))
    }
}
