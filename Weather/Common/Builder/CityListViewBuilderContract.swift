//
//  CityListBuilderContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol CityListViewBuilding {
    func buildCityListView(storage: CityPersistanceStoreProtocol, builder: CityListBuilding) -> AnyView
}

extension CityListViewBuilding {
    func buildCityListView(storage: CityPersistanceStoreProtocol, builder: CityListBuilding) -> AnyView {
        let cityListViewModel = CityListViewModel(storage: storage, builder: builder)
        return AnyView(CityList(viewModel: cityListViewModel))
    }
}

final class CityListViewBuilder: CityListViewBuilding {}
