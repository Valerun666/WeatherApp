//
//  HourlyForecastDetailsRow.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyForecastDetailsRow: View {
    private var viewModel: HourlyForecastDetailsRowViewModel

    init(viewModel: HourlyForecastDetailsRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text("Date: \(viewModel.time)").bold()
                Spacer()
                Text("🌤 \(viewModel.temperature)°").bold()
            }
            HStack {
                Text("Feels like: \(viewModel.feelsLike)°")
                Spacer()
                Text("(\(viewModel.weather))")
            }
            HStack {
                Text("Humidity:")
                Spacer()
                Text("\(viewModel.humidity)%")
            }
            HStack {
                Text("Wind speed:")
                Spacer()
                Text("\(viewModel.windSpeed) metre/sec")
            }
        }
    }
}
