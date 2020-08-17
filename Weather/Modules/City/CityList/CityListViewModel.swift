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
    private let persistentStorage: CityPersistenceStoreProtocol

    private var disposables = Set<AnyCancellable>()
    private let router: CityListRouterInput

    init(persistentStorage: CityPersistenceStoreProtocol, router: CityListRouterInput) {
        self.persistentStorage = persistentStorage
        self.router = router
    }
}

extension CityListViewModel: CityListViewModelProtocol {
    func didLoad() {
        subscribeOnStorageUpdate()
        loadCities()
    }

    func remove(at offsets: IndexSet) {
        persistentStorage.remove(at: offsets)
    }
    
    func didTapAddCity() {
        router.showAddCity(persistentStorage: persistentStorage)
        navigationTag = .showAddCity
    }
}

private extension CityListViewModel {
    func subscribeOnStorageUpdate() {
        persistentStorage.storageDidChange.sink { [weak self] city in
            self?.state = .data(city)
        }.store(in: &disposables)
    }

    func loadCities() {
        state = .loading
        let cities = persistentStorage.fetch()
        guard !cities.isEmpty else {
            state = .empty
            return
        }

        state = .data(cities)
    }
}
