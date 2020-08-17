//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 16.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Combine
import GooglePlaces

final class AddCityViewModel {
    private let persistentStorage: CityPersistenceStoreProtocol

    private var disposables = Set<AnyCancellable>()

    init(persistentStorage: CityPersistenceStoreProtocol) {
        self.persistentStorage = persistentStorage
    }
}

extension AddCityViewModel: AddCityViewModelProtocol {
    func didSelect(place: GMSPlace, onComplete: @escaping () -> Void) {
        guard let name = place.name else {
            return
        }
        let city = City(name: name, lat: place.coordinate.latitude, lon: place.coordinate.longitude)
        persistentStorage.add(city)
    }
}
