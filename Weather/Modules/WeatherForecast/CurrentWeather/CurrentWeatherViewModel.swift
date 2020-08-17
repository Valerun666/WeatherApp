//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

class CurrentWeatherViewModel {
    @Published private(set) var state: ViewState<[CurrentWeatherRowViewModel]> = .loading
    @Published var navigationTag: CurrentWeatherNavigationTag? = nil
    private let persistentStorage: CityPersistenceStoreProtocol

    private var weatherForecasts = [CurrentWeatherRowViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }

    private var response = [CurrentWeatherForecastResponse]()

    private let networkClient: NetworkClientType
    private let router: CurrentWeatherRouterInput

    private var disposables = Set<AnyCancellable>()

    init(networkClient: NetworkClientType,
         persistentStorage: CityPersistenceStoreProtocol,
         router: CurrentWeatherRouterInput) {
        self.networkClient = networkClient
        self.persistentStorage = persistentStorage
        self.router = router
        self.subscribeOnStorageUpdate()
        self.refreshData()
    }
}

extension CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    func didTapOnCell(index: Int) {
        router.showCurrentWeatherDetails(response[index])
        navigationTag = .showCurrentWeatherDetails
    }

    func refresh() {
        refreshData()
    }
}

private extension CurrentWeatherViewModel {
    func subscribeOnStorageUpdate() {
        persistentStorage.storageDidChange.sink { [weak self] value in
            self?.refreshData()
        }.store(in: &disposables)
    }

    func refreshData() {
        state = .loading
        weatherForecasts = []
        response = []
        let cities = persistentStorage.fetch()

        guard !cities.isEmpty else {
            state = .empty
            return
        }

        let publishers = cities.compactMap { [weak self] city in
            self?.networkClient.execute(request: WeatherServiceProvider.currentWeather(cityId: city.name),
            with: CurrentWeatherForecastResponse.self)
        }

        Publishers.MergeMany(publishers)
            .receive(on: DispatchQueue.global())
            .collect()
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                print(value)
                switch value {
                case .failure: self.state = .error
                case .finished: break
                }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.updateData(with: response)
            })
            .store(in: &disposables)
    }

    func updateData(with response: [CurrentWeatherForecastResponse]) {
        self.response.append(contentsOf: response)
        let result = response.map(CurrentWeatherRowViewModel.init(item:))
        DispatchQueue.main.async {
            self.weatherForecasts.append(contentsOf: result)
        }
    }
}
