//
//  HourlyWeatherContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol HourlyWeatherViewModelProtocol: ViewModel, CityListPresentable {
    var state: ViewState<[HourlyWeatherSectionViewModel]> { get }
}
