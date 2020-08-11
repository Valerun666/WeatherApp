//
//  HourlyWeatherRow.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyWeatherRow: View {
    private let viewModel: HourlyWeatherRowViewModel

    init(viewModel: HourlyWeatherRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text(viewModel.time)
            Text(viewModel.temperature)
        }
    }
}
