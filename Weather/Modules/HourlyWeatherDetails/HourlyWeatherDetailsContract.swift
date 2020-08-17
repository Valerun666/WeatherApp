//
//  HourlyWeatherDetailsContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

protocol HourlyWeatherDetailsViewModelProtocol: ViewModel {
    var state: ViewState<HourlyWeatherForecastViewModel> { get }
}
