//
//  CurrentWeatherDetailsContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

protocol CurrentWeatherDetailsViewModelProtocol: ViewModel {
    var state: ViewState<CurrentWeatherForecastViewModel> { get }
    var title: String { get }
}
