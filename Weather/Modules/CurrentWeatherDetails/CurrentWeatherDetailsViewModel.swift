//
//  CurrentWeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class CurrentWeatherDetailsViewModel: CurrentWeatherDetailsViewModelProtocol {
    @Published private(set) var state: ViewState<CurrentWeatherForecastViewModel> = .loading
    private let data: CurrentWeatherForecastResponse

    public var title: String {
        data.name
    }

    init(data: CurrentWeatherForecastResponse) {
        self.data = data
        state = .data(CurrentWeatherForecastViewModel(item: data))
    }
}
