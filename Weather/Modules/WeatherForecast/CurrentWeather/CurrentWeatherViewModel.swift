//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

final class CurrentWeatherViewModel {
    @Published private(set) var state: ViewState<[CurrentWeatherRowViewModel]> = .loading
    @Published var navigationTag: CurrentWeatherNavigationTag? = nil

    private var weatherForecasts = [CurrentWeatherRowViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }

    private var response = [CurrentWeatherForecastResponse]()

    private let networkClient: NetworkClientType
    private let storage: CityPersistanceStoreProtocol
    private let router: CurrentWeatherRouterInput

    private var disposables = Set<AnyCancellable>()

    init(networkClient: NetworkClientType,
         storage: CityPersistanceStoreProtocol,
         router: CurrentWeatherRouterInput) {
        self.networkClient = networkClient
        self.storage = storage
        self.router = router
        refreshData()
    }
}

extension CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    func didTapOnCell(index: Int) {
        router.showCurrentWeatherDetails(response[index])
        navigationTag = .showCurrentWeatherDetails
    }
}

private extension CurrentWeatherViewModel {
    func testData() {
        storage.add(City(name: "Moscow", lat: 60.99, lon: 30.9))
        storage.add(City(name: "Chicago", lat: 33.441792, lon: -94.037689))
    }

    func refreshData() {
        state = .loading
        weatherForecasts = []
        response = []
        let cities = storage.fetch()

        guard !cities.isEmpty else {
            state = .empty
            return
        }

        let publishers = cities.compactMap({ [weak self] city in
            self?.networkClient.execute(request: WeatherServiceProvider.currentWeather(cityId: city.name),
                                        with: CurrentWeatherForecastResponse.self)
        })

        Publishers.MergeMany(publishers)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                print(value)
                switch value {
                case .failure: self.state = .error
                case .finished: break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.response.append(response)
                self.weatherForecasts.append(CurrentWeatherRowViewModel(item: response))
            })
            .store(in: &disposables)
    }
}
