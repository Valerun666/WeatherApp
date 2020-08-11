//
//  WeatherForecastBuilder.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class WeatherForecastBuilder: WeatherForecastBuiling {
    func buildCurrentWeatherForecastView(networkClient: NetworkClientType, storage: CityPersistanceStoreContract) -> AnyView {
        let currentWeatherViewModel = CurrentWeatherViewModel(networkClient: networkClient,
                                                              storage: storage)
        return AnyView(CurrentWeatherForecast(viewModel: currentWeatherViewModel))
    }

    func buildHourlyWeatherForecastView(networkClient: NetworkClientType, storage: CityPersistanceStoreContract) -> AnyView {
        AnyView(HourlyWeatherForecast())
    }

    func buildCityListView(storage: CityPersistanceStoreContract) -> AnyView {
        AnyView(Text("City List View"))
    }
}
