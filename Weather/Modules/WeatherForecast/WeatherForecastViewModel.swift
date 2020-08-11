//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class WeatherForecastViewModel {
    private let builder: WeatherForecastBuiling

    init(builder: WeatherForecastBuiling) {
        self.builder = builder
    }
}

extension WeatherForecastViewModel: WeatherForecastViewModelProtocol {
    var currentWeatherView: AnyView {
        let networkClient = NetworkClient(urlBuilder: URLBuilder())
        return builder.buildCurrentWeatherForecastView(networkClient: networkClient,
                                                       storage: CityPersistanceCoordinator(),
                                                       cityListBuilder: CityListViewBuilder())
    }

    var hourlyWeatherView: AnyView {
        let networkClient = NetworkClient(urlBuilder: URLBuilder())
        return builder.buildHourlyWeatherForecastView(networkClient: networkClient,
                                                      storage: CityPersistanceCoordinator(),
                                                      cityListBuilder: CityListViewBuilder())
    }
}
