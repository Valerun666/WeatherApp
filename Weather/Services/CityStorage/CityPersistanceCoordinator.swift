//
//  CityPersistanceCoordinator.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class CityPersistanceCoordinator: CityPersistanceStoreContract {
    private enum CityPersistanceKey: String {
        case cityList
    }

    private var storage: [String] {
        get {
            guard let cityList = UserDefaults.standard.stringArray(forKey: CityPersistanceKey.cityList.rawValue) else {
                return []
            }

            return cityList
        }
        set {
            UserDefaults.standard.set(newValue, forKey: CityPersistanceKey.cityList.rawValue)
        }
    }

    func add(_ value: String) {
        guard !storage.contains(value) else {
            return
        }

        var newStorage = storage
        newStorage.append(value)
        storage = newStorage
    }

    func delete(_ value: String) -> String? {
        guard storage.contains(value) else {
            return nil
        }

        storage = storage.filter({ $0 != value })
        return value
    }

    func fetch() -> [String] {
        storage
    }
    
}
