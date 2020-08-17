//
//  HourlyWeatherDetails.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyWeatherDetails<ViewModel: HourlyWeatherDetailsViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
    }
}

private extension HourlyWeatherDetails {
    var contentView: some View {
        switch viewModel.state {
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true), style: .large))
        case .data(let weatherForecast):
            return AnyView(contentView(with: weatherForecast))
        case .error:
            return AnyView(Text("Something went wrong..."))
        case .empty:
            return AnyView(Text("No yet any city. Please add the city to the list"))
        }
    }

    func contentView(with weatherForecast: HourlyWeatherForecastViewModel) -> some View {
        List{
            header(with: weatherForecast)
            ForEach(weatherForecast.rows) { model in
                HourlyForecastDetailsRow(viewModel: model)
            }
        }
    }

    func header(with weatherForecast: HourlyWeatherForecastViewModel) -> some View {
        Section {
            VStack {
                MapView(coordinate: weatherForecast.coordinate)
                    .frame(height: 300)
                    .disabled(true)
                Text("Timezone: \(weatherForecast.timezone)")
                    .font(.body)
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
            }
        }
    }
}
