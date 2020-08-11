//
//  PersistanceContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

protocol CityPersistanceStoreContract {
    func add(_ city: String)
    func delete(_ city: String) -> String?
    func fetch() -> [String]
}

