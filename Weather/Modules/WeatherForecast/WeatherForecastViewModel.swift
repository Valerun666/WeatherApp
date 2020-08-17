//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class WeatherForecastViewModel {
    private let router: WeatherForecastRouterInput
    private let persistentStorage: CityPersistenceStoreProtocol
    @Published var navigationTag: WeatherNavigationTag?


    init(router: WeatherForecastRouterInput, persistentStorage: CityPersistenceStoreProtocol) {
        self.router = router
        self.persistentStorage = persistentStorage
    }
}

extension WeatherForecastViewModel: WeatherForecastViewModelProtocol {
    func didTapCitiesButton() {
        router.showCityList(persistentStorage: persistentStorage)
        navigationTag = .showCityList
    }
}
