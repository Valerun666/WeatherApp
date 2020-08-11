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
    private let builder: CityListViewBuilding

    private var disposables = Set<AnyCancellable>()

    init(networkClient: NetworkClientType,
         storage: CityPersistanceStoreProtocol,
         builder: CityListViewBuilding) {
        self.networkClient = networkClient
        self.storage = storage
        self.builder = builder

        //MARK: Remove!!!!
        testData()

        refreshData()
    }
}

extension CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    var cityList: AnyView {
        builder.buildCityListView(storage: storage, builder: CityListBuilder())
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
