//
//  CityListRouter.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 12.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

final class CityListRouter: CityListRouterOutput {
    var addCity: AnyView = .init(EmptyView())

}

extension CityListRouter: CityListRouterInput {
    func showAddCity() {
        addCity = AnyView(Text("Add city"))
    }
}
