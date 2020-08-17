//
//  WeatherForecastRouter.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class WeatherForecastRouter: WeatherForecastRouterOutput {
    @Published var cityList: AnyView = .init(EmptyView())

    private let storage: CityPersistenceStoreProtocol

    init(storage: CityPersistenceStoreProtocol) {
        self.storage = storage
    }
}

extension WeatherForecastRouter: WeatherForecastRouterInput {
    func showCityList(persistentStorage: CityPersistenceStoreProtocol) {
        let router = CityListRouter()
        let cityListViewModel = CityListViewModel(persistentStorage: persistentStorage, router: router)
        cityList = AnyView(CityList(viewModel: cityListViewModel, router: router))
    }
}


