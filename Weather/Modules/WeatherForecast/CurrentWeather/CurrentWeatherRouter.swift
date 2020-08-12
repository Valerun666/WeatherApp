//
//  Router.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class CurrentWeatherRouter: CurrentWeatherRouterOutput {
    @Published var currentWeatherDetails: AnyView = .init(EmptyView())
}

extension CurrentWeatherRouter: CurrentWeatherRouterInput {
    func showCurrentWeatherDetails(_ data: CurrentWeatherForecastResponse) {
        currentWeatherDetails = AnyView(Text("Current Weather Details"))
    }
}
