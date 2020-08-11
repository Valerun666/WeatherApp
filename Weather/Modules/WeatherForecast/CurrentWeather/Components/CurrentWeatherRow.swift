//
//  CurrentWeatherRow.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CurrentWeatherRow: View {
    private let viewModel: CurrentWeatherRowViewModel

    init(viewModel: CurrentWeatherRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
            HStack {
                Text("☀️ Temperature:")
                Text("\(viewModel.temperature)°")
                  .foregroundColor(.gray)
            }

            HStack {
                Text("📈 Max temperature:")
                Text("\(viewModel.maxTemperature)°")
                  .foregroundColor(.gray)
            }

            HStack {
                Text("📉 Min temperature:")
                Text("\(viewModel.minTemperature)°")
                  .foregroundColor(.gray)
            }

            HStack {
                Text("💧 Humidity:")
                Text(viewModel.humidity)
                  .foregroundColor(.gray)
            }
        }
    }
}
