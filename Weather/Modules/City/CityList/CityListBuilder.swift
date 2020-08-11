//
//  CityListBuilder.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol CityListBuilding {
    func buildAddCity(storage: CityPersistanceStoreProtocol) -> AnyView
}

extension CityListBuilding {
    func buildAddCity(storage: CityPersistanceStoreProtocol) -> AnyView {
        AnyView(AddCity())
    }
}

final class CityListBuilder: CityListBuilding {}
