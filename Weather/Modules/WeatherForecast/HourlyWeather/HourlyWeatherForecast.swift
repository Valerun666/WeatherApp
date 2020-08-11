//
//  HourlyWeatherForecast.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyWeatherForecast<ViewModel: HourlyWeatherViewModelProtocol>: View {
    let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle("Weather ⛅️", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: viewModel.cityList) {
                        Text("Cities")
                    }
                )
        }
    }
}


private extension HourlyWeatherForecast {
    var contentView: some View {
        switch viewModel.state {
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true), style: .large))
        case .data(let weatherForecast):
            return AnyView(contentView(with: weatherForecast))
        case .error:
            return AnyView(Text("Error"))
        case .empty:
            return AnyView(Text("No yet any city. Please add the city to the list"))
        }
    }

    func contentView(with forecast: [HourlyWeatherSectionViewModel]) -> some View {
        List {
            ForEach(forecast) { model in
                Group {
                    Section {
                        Text(model.name)
                    }
                    Section {
                        ForEach(model.hourlyForecast) { model in
                            HourlyWeatherRow(viewModel: model)
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}
