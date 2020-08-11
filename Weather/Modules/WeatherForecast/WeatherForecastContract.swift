//
//  WeatherForecastContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol WeatherForecastBuiling {
    func buildCurrentWeatherForecastView(networkClient: NetworkClientType,
                                         storage: CityPersistanceStoreProtocol,
                                         cityListBuilder: CityListViewBuilding) -> AnyView
    func buildHourlyWeatherForecastView(networkClient: NetworkClientType,
                                        storage: CityPersistanceStoreProtocol,
                                        cityListBuilder: CityListViewBuilding) -> AnyView
}

protocol WeatherForecastViewModelProtocol: ViewModel {
    var currentWeatherView: AnyView { get }
    var hourlyWeatherView: AnyView { get }
}
