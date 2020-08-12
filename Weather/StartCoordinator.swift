//
//  StartCoordinator.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol StartCoordinatorProtcol {
    var initialModule: AnyView { get }
    var currentWeather: AnyView { get }
    var hourlyWeather: AnyView { get }
}

final class StartCoordinator: StartCoordinatorProtcol {
    var initialModule: AnyView {
        let router = WeatherForecastRouter(storage: CityPersistanceCoordinator())
        let weatherForecastViewModel = WeatherForecastViewModel(router: router)
        let view = WeatherForecast(viewModel: weatherForecastViewModel,
                                   router: router,
                                   currentWeatherView: currentWeather,
                                   hourlyWeatherView: hourlyWeather)
        
        return AnyView(view)
    }

    var currentWeather: AnyView {
        let router = CurrentWeatherRouter()
        let networkClient = NetworkClient(urlBuilder: URLBuilder())
        let currentWeatherViewModel = CurrentWeatherViewModel(networkClient: networkClient,
                                                              storage: CityPersistanceCoordinator(),
                                                              router: router)
        return AnyView(CurrentWeatherForecast(viewModel: currentWeatherViewModel, router: router))
    }

    var hourlyWeather: AnyView {
        let router = HourlyWeatherRouter()
        let networkClient = NetworkClient(urlBuilder: URLBuilder())
        let hourlyWeatherViewModel = HourlyWeatherViewModel(networkClient: networkClient,
                                                            storage: CityPersistanceCoordinator(),
                                                            mapper: HourlyWeatherMapper(),
                                                            router: router)
        return AnyView(HourlyWeatherForecast(viewModel: hourlyWeatherViewModel, router: router))
    }

}
