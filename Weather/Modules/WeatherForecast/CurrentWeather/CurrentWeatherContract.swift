//
//  CurrentWeatherContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

enum CurrentWeatherNavigationTag: String {
    case showCurrentWeatherDetails
}

protocol CurrentWeatherViewModelProtocol: ViewModel {
    var state: ViewState<[CurrentWeatherRowViewModel]> { get }
    var navigationTag: CurrentWeatherNavigationTag? { get set }

    func didTapOnCell(index: Int)
}

protocol CurrentWeatherRouterOutput: Router {
    var currentWeatherDetails: AnyView { get set }
}

protocol CurrentWeatherRouterInput {
    func showCurrentWeatherDetails(_ data: CurrentWeatherForecastResponse)
}
