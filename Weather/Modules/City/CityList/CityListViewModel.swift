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
    var navigationTagDidChanged = PassthroughSubject<Void,Never>()

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
    }

    func remove(at offsets: IndexSet) {
        storage.remove(at: offsets)
        updateCityList()
    }
    
    func didTapAddCity() {
        router.showAddCity()
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
}
