//
//  WeatherForecastContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

enum WeatherNavigationTag: String {
    case showCityList
}

protocol WeatherForecastRouterOutput: Router {
    var cityList: AnyView { get set }
}

protocol WeatherForecastRouterInput {
    func showCityList()
}

protocol WeatherForecastViewModelProtocol: ViewModel {
    var navigationTag: WeatherNavigationTag? { get set }

    func didTapCitiesButton()
}
