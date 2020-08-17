//
//  HourlyWeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class HourlyWeatherDetailsViewModel: HourlyWeatherDetailsViewModelProtocol {
    @Published private(set) var state: ViewState<HourlyWeatherForecastViewModel> = .loading
    private let data: HourlyWeatherForecastResponse
    
    init(data: HourlyWeatherForecastResponse) {
        self.data = data
        state = .data(HourlyWeatherForecastViewModel(item: data))
    }
}
