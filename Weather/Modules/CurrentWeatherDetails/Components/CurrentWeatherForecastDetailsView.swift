//
//  CurrentWeatherForecastDetailsView.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CurrentWeatherForecastDetailsView: View {
    private let viewModel: CurrentWeatherForecastViewModel

    init(viewModel: CurrentWeatherForecastViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            MapView(coordinate: viewModel.coordinate)
                .frame(height: 300)
                .disabled(true)

            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature:")
                    Text("\(viewModel.temperature)°")
                        .foregroundColor(.gray)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

                HStack {
                    Text("📈 Max temperature:")
                    Text("\(viewModel.maxTemperature)°")
                        .foregroundColor(.gray)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

                HStack {
                    Text("📉 Min temperature:")
                    Text("\(viewModel.minTemperature)°")
                        .foregroundColor(.gray)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

                HStack {
                    Text("💧 Humidity:")
                    Text(viewModel.humidity)
                        .foregroundColor(.gray)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            Spacer()
        }
    }
}
