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

    private let storage: CityPersistanceStoreProtocol

    init(storage: CityPersistanceStoreProtocol) {
        self.storage = storage
    }
}

extension WeatherForecastRouter: WeatherForecastRouterInput {
    func showCityList() {
        let router = CityListRouter()
        let cityListViewModel = CityListViewModel(storage: storage, router: router)
        cityList = AnyView(CityList(viewModel: cityListViewModel, router: router))
    }
}


