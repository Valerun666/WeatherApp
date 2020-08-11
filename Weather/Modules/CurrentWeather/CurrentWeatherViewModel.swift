//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    @Published private(set) var state: ViewState<[CurrentWeatherRowViewModel]> = .loading

    private var weatherForecasts = [CurrentWeatherRowViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }

    private let networkClient: NetworkClientType
    private let storage: CityPersistanceStoreContract

    private var disposables = Set<AnyCancellable>()

    init(networkClient: NetworkClientType,
         storage: CityPersistanceStoreContract) {
        self.networkClient = networkClient
        self.storage = storage
        storage.add("Kiev")
        storage.add("Rome")
        refreshData()
    }
}

private extension CurrentWeatherViewModel {
    func refreshData() {
        state = .loading
        weatherForecasts = []
        let cities = storage.fetch()
        let publishers = cities.compactMap({ [weak self] city in
            self?.networkClient.execute(request: WeatherServiceProvider.currentWeather(cityId: city),
                                        with: CurrentWeatherForecastResponse.self)
        })

        Publishers.MergeMany(publishers)
            .compactMap(CurrentWeatherRowViewModel.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                print(value)
                switch value {
                case .failure: self.state = .error
                case .finished: break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                self.weatherForecasts.append(weather)
            })
            .store(in: &disposables)
    }
}
