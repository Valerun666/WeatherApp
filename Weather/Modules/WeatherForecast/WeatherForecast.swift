//
//  WeatherForecast.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct WeatherForecast: View {
    private var viewModel: WeatherForecastViewModel

    init(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        TabView {
            viewModel.currentWeatherView
                .tabItem {
                    Image(systemName: "cloud.sun.bolt.fill")
                    Text("Current weather")
            }
            viewModel.hourlyWeatherView
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Hourly weather")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecast(viewModel: WeatherForecastViewModel(builder: WeatherForecastBuilder()))
    }
}
