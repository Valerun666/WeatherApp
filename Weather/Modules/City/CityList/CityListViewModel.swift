//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

final class CityListViewModel {
    @Published private(set) var state: ViewState<[City]> = .loading
    @Published var navigationTag: CityListNavigationTag? = nil {
        didSet {
            if navigationTag != nil {
                objectWillChange.send()
            }
        }
    }
    var newCity = PassthroughSubject<City?, Never>()
    private var disposables = Set<AnyCancellable>()

    private let storage: CityPersistanceStoreProtocol
    private let router: CityListRouterInput

    init(storage: CityPersistanceStoreProtocol, router: CityListRouterInput) {
        self.storage = storage
        self.router = router
    }
}

extension CityListViewModel: CityListViewModelProtocol {
    func didLoad() {
        updateCityList()
        subscribeOnCityUpdate()
    }

    func remove(at offsets: IndexSet) {
        storage.remove(at: offsets)
        updateCityList()
    }
    
    func didTapAddCity() {
        router.showAddCity(city: newCity)
        navigationTag = .showAddCity
    }
}

private extension CityListViewModel {
    func updateCityList() {
        state = .loading
        let cityList = storage.fetch()
        if cityList.isEmpty {
            state = .empty
        } else {
            state = .data(cityList)
        }
    }

    func didAddNewCity(_ city: City?) {
        guard let city = city else {
            return
        }
        storage.add(city)
        updateCityList()
    }

    func subscribeOnCityUpdate() {
        newCity.sink { [weak self] city in
            self?.didAddNewCity(city)
        }
        .store(in: &disposables)
    }
}
