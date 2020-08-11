//
//  CurrentWeatherContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

protocol CurrentWeatherViewModelProtocol: ViewModel {
    var state: ViewState<[CurrentWeatherRowViewModel]> { get }
}
