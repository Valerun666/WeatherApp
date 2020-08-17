//
//  PersistanceContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import Combine

protocol CityPersistenceStoreProtocol {
    func add(_ city: City)
    func remove(_ city: City) -> City?
    func remove(at offsets: IndexSet)
    func fetch() -> [City]

    var storageDidChange: Publishers.Multicast<PassthroughSubject<[City], Never>,
        PassthroughSubject<[City], Never>> { get }
}




