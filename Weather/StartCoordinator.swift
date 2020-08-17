//
//  StartCoordinator.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import GooglePlaces

protocol StartCoordinatorProtcol {
    var initialModule: AnyView { get }
    var currentWeather: AnyView { get }
    var hourlyWeather: AnyView { get }
}

final class StartCoordinator: StartCoordinatorProtcol {
    let persistentStorage: CityPersistanceCoordinator

    init() {
        self.persistentStorage = CityPersistanceCoordinator()
        GMSPlacesClient.provideAPIKey(Constants.GooglePlacesApiKey)
    }

    var initialModule: AnyView {
        let router = WeatherForecastRouter(storage: CityPersistanceCoordinator())
        let weatherForecastViewModel = WeatherForecastViewModel(router: router, persistentStorage: persistentStorage)
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
                                                              persistentStorage: persistentStorage,
                                                              router: router)

        return AnyView(CurrentWeatherForecast(viewModel: currentWeatherViewModel, router: router))
    }

    var hourlyWeather: AnyView {
        let router = HourlyWeatherRouter()
        let networkClient = NetworkClient(urlBuilder: URLBuilder())
        let hourlyWeatherViewModel = HourlyWeatherViewModel(networkClient: networkClient,
                                                            persistentStorage: persistentStorage,
                                                            router: router)
        return AnyView(HourlyWeatherForecast(viewModel: hourlyWeatherViewModel, router: router))
    }

}
