//
//  WeatherForecastBuilder.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class WeatherForecastBuilder: WeatherForecastBuiling {
    func buildCurrentWeatherForecastView(networkClient: NetworkClientType,
                                         storage: CityPersistanceStoreProtocol,
                                         cityListBuilder: CityListViewBuilding) -> AnyView {
        let currentWeatherViewModel = CurrentWeatherViewModel(networkClient: networkClient,
                                                              storage: storage,
                                                              builder: cityListBuilder)
        return AnyView(CurrentWeatherForecast(viewModel: currentWeatherViewModel))
    }

    func buildHourlyWeatherForecastView(networkClient: NetworkClientType,
                                        storage: CityPersistanceStoreProtocol,
                                        cityListBuilder: CityListViewBuilding) -> AnyView {
        let hourlyWeatherViewModel = HourlyWeatherViewModel(networkClient: networkClient,
                                                            storage: storage,
                                                            builder: cityListBuilder)
        return AnyView(HourlyWeatherForecast(viewModel: hourlyWeatherViewModel))
    }
}
