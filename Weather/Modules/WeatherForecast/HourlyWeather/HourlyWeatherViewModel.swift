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

    private var weatherForecasts = [HourlyWeatherSectionViewModel]() {
        didSet {
            if !weatherForecasts.isEmpty {
                state = .data(weatherForecasts)
            }
        }
    }
    private var data = [HourlyWeatherForecastModel]()

    private let networkClient: NetworkClientType
    private let storage: CityPersistanceStoreProtocol
    private let mapper: HourlyWeatherMapper
    private let router: HourlyWeatherRouterInput

    private var disposables = Set<AnyCancellable>()
    
    init(networkClient: NetworkClientType,
         storage: CityPersistanceStoreProtocol,
         mapper: HourlyWeatherMapper,
         router: HourlyWeatherRouterInput) {
        self.networkClient = networkClient
        self.storage = storage
        self.mapper = mapper
        self.router = router
        refreshData()
    }
}

extension HourlyWeatherViewModel: HourlyWeatherViewModelProtocol {
    func didTapOnCell(index: Int) {
        router.showHourlyWeatherDetails()
        navigationTag = .showHourlyWeatherDetails
    }
}

private extension HourlyWeatherViewModel {
    func refreshData() {
        state = .loading
        weatherForecasts = []
        let cities = storage.fetch()
        mapper.setupCityList(cityList: cities)

        guard !cities.isEmpty else {
            state = .empty
            return
        }
        
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
                self.updateData(with: response)
            })
            .store(in: &disposables)
    }

    func updateData(with response: HourlyWeatherForecastResponse) {
        guard let result = self.mapper.map(response) else {
            state = .error
            return
        }

        self.data.append(result)
        self.weatherForecasts.append(HourlyWeatherSectionViewModel(item: result))
    }
}
