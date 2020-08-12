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
    @Published var navigationTag: WeatherNavigationTag?


    init(router: WeatherForecastRouterInput) {
        self.router = router
    }
}

extension WeatherForecastViewModel: WeatherForecastViewModelProtocol {
    func didTapCitiesButton() {
        router.showCityList()
        navigationTag = .showCityList
    }
}
