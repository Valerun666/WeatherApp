//
//  CityPersistanceCoordinator.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class CityPersistanceCoordinator: CityPersistanceStoreProtocol {
    private enum CityPersistanceKey: String {
        case cityList
    }

    private var storage: [City] {
        get {
            guard let data = UserDefaults.standard.data(forKey: CityPersistanceKey.cityList.rawValue) else {
                return []
            }

            return try! PropertyListDecoder().decode([City].self, from: data)
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: CityPersistanceKey.cityList.rawValue)
            }
        }
    }

    func add(_ value: City) {
        guard !storage.contains(value) else {
            return
        }

        var newStorage = storage
        newStorage.append(value)
        storage = newStorage
    }

    func remove(_ value: City) -> City? {
        guard storage.contains(value) else {
            return nil
        }

        storage = storage.filter({ $0 != value })
        return value
    }

    func remove(at offsets: IndexSet) {
        var newStorage = storage
        newStorage.remove(atOffsets: offsets)
        storage = newStorage
    }

    func fetch() -> [City] {
        storage
    }
    
}
