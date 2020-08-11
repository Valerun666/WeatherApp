//
//  CityRow.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CityRow: View {
    private let city: City

    init(city: City) {
        self.city = city
    }

    var body: some View {
        Text(city.name)
    }
}
