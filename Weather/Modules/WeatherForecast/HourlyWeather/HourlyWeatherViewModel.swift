//
//  HourlyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

final class HourlyWeatherViewModel {
    @Published private(set) var state: ViewState<[HourlyWeatherSectionViewModel]> = .loading
    @Published var navigationTag: HourlyWeatherNavigationTag?
    private let persistentStorage: CityPersistenceStoreProtocol

    private var weatherForecasts = [HourlyWeatherSectionViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }
    private var data = [HourlyWeatherForecastResponse]()

    private let networkClient: NetworkClientType
    private let router: HourlyWeatherRouterInput

    private var disposables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientType,
         persistentStorage: CityPersistenceStoreProtocol,
         router: HourlyWeatherRouterInput) {
        self.networkClient = networkClient
        self.persistentStorage = persistentStorage
        self.router = router
        subscribeOnStorageUpdate()
        refreshData()
    }
}

extension HourlyWeatherViewModel: HourlyWeatherViewModelProtocol {
    func didTapOnCell(index: Int) {
        router.showHourlyWeatherDetails(data: data[index])
        navigationTag = .showHourlyWeatherDetails
    }

    func refresh() {
        refreshData()
    }
}

private extension HourlyWeatherViewModel {
    func subscribeOnStorageUpdate() {
        persistentStorage.storageDidChange.sink { [weak self] value in
            self?.refreshData()
        }
        .store(in: &disposables)
    }

    func refreshData() {
        state = .loading
        weatherForecasts = []
        let cities = persistentStorage.fetch()

        guard !cities.isEmpty else {
            state = .empty
            return
        }
        
        Publishers.MergeMany(publishers(for: cities))
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

    func publishers(for cities: [City]) -> [AnyPublisher<HourlyWeatherForecastResponse, Error>] {
        return cities.compactMap({ [weak self] city in
            self?.networkClient.execute(request: WeatherServiceProvider.hourlyForecast(lat: "\(city.lat)",
                lon: "\(city.lon)"), with: HourlyWeatherForecastResponse.self)
        })
    }

    func updateData(with response: [HourlyWeatherForecastResponse]) {
        self.data.append(contentsOf: response)
        let result = response.map(HourlyWeatherSectionViewModel.init(item:))
        DispatchQueue.main.async { [weak self] in
            self?.weatherForecasts.append(contentsOf: result)
        }
    }
}
