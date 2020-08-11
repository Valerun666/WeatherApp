//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class CityListViewModel {
    @Published private(set) var state: ViewState<[City]> = .loading

    private let storage: CityPersistanceStoreProtocol
    private let builder: CityListBuilding

    init(storage: CityPersistanceStoreProtocol, builder: CityListBuilding) {
        self.storage = storage
        self.builder = builder
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
    
    var addCity: AnyView {
        builder.buildAddCity(storage: storage)
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
