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

    private var weatherForecasts = [HourlyWeatherSectionViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }
    private var response = [HourlyWeatherForecastResponse]()

    private let networkClient: NetworkClientType
    private let storage: CityPersistanceStoreProtocol
    private let builder: CityListViewBuilding

    private var disposables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientType,
         storage: CityPersistanceStoreProtocol,
         builder: CityListViewBuilding) {
        self.networkClient = networkClient
        self.storage = storage
        self.builder = builder
        refreshData()
    }
}

extension HourlyWeatherViewModel: HourlyWeatherViewModelProtocol {
    var cityList: AnyView {
        builder.buildCityListView(storage: storage, builder: CityListBuilder())
    }
}

private extension HourlyWeatherViewModel {
    func refreshData() {
        state = .loading
        weatherForecasts = []
        let cities = storage.fetch()
        let publishers = cities.compactMap({ [weak self] city in
            self?.networkClient.execute(request: WeatherServiceProvider.hourlyForecast(lat: "\(city.lat)",
                lon: "\(city.lon)"), with: HourlyWeatherForecastResponse.self)
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
                self.weatherForecasts.append(HourlyWeatherSectionViewModel(item: response))
            })
            .store(in: &disposables)
    }
}
