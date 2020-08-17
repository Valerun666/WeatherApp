//
//  WeatherForecast.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct WeatherForecast<Router: WeatherForecastRouterOutput>: View {
    enum TabTag: Int {
        case currentWeather = 0
        case hourlyWeather = 1
    }

    @ObservedObject var viewModel: WeatherForecastViewModel
    @ObservedObject var router: Router
    @State private var selection = 0

    let currentWeatherView: AnyView
    let hourlyWeatherView: AnyView

    init(viewModel: WeatherForecastViewModel,
         router: Router,
         currentWeatherView: AnyView,
         hourlyWeatherView: AnyView) {
        self.viewModel = viewModel
        self.router = router
        self.currentWeatherView = currentWeatherView
        self.hourlyWeatherView = hourlyWeatherView
    }

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                currentWeatherView
                    .tabItem {
                        Image(systemName: "cloud.sun.bolt.fill")
                        Text("Current weather")
                }
                .tag(TabTag.currentWeather.rawValue)

                hourlyWeatherView
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("Hourly weather")
                }
                .tag(TabTag.hourlyWeather.rawValue)
            }
            .navigationBarTitle("Weather ⛅️", displayMode: .inline)
            .navigationBarItems(trailing:
                citiesBarButton
            )
        }
    }
}

private extension WeatherForecast {
    var citiesBarButton: some View {
        ZStack {
            NavigationLink(destination: router.cityList,
                           tag: WeatherNavigationTag.showCityList,
                           selection: $viewModel.navigationTag,
                           label: { EmptyView() })
            Button(action: {
                self.viewModel.didTapCitiesButton()
            }, label: {
                Text("Cities")
            })
        }
    }
}
