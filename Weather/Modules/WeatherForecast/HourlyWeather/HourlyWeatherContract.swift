//
//  HourlyWeatherContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

enum HourlyWeatherNavigationTag: String {
    case showHourlyWeatherDetails
}

protocol HourlyWeatherViewModelProtocol: ViewModel {
    var state: ViewState<[HourlyWeatherSectionViewModel]> { get }
    var navigationTag: HourlyWeatherNavigationTag? { get set }

    func didTapOnCell(index: Int)
}

protocol HourlyWeatherRouterOutput: Router {
    var hourlyWeatherDetails: AnyView { get set }
}

protocol HourlyWeatherRouterInput {
    func showHourlyWeatherDetails(data: HourlyWeatherForecastResponse)
}
