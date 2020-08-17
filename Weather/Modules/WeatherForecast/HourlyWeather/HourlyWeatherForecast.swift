//
//  HourlyWeatherForecast.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 10.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct HourlyWeatherForecast<ViewModel: HourlyWeatherViewModelProtocol, Router: HourlyWeatherRouterOutput>: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var router: Router

    init(viewModel: ViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
    }
    
    var body: some View {
        VStack {
            contentView
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
            return AnyView(Text("Something went wrong..."))
        case .empty:
            return AnyView(Text("No yet any city. Please add the city to the list"))
        }
    }

    func contentView(with forecast: [HourlyWeatherSectionViewModel]) -> some View {
        ZStack {
            NavigationLink(destination: router.hourlyWeatherDetails,
                           tag: HourlyWeatherNavigationTag.showHourlyWeatherDetails,
                           selection: $viewModel.navigationTag,
                           label: { EmptyView() })
            GeometryReader { (geometry) in
                ScrollView(width: geometry.size.width, height: geometry.size.height, viewModel: self.viewModel) {
                    self.listView(forecast: forecast)
                }
            }
        }
    }

    func rowFor(index: Int, model: HourlyWeatherSectionViewModel) -> some View {
        Button(action: {
            self.viewModel.didTapOnCell(index: index)
        }, label: {
            Text("Timezone: \(model.timeZone)")
        })
    }
}

private extension HourlyWeatherForecast {
    func listView(forecast: [HourlyWeatherSectionViewModel]) -> some View  {
        let withIndex = forecast.enumerated().map({ $0 })

        return List {
            ForEach(withIndex, id: \.element.timeZone) { index, model in
                Group {
                    self.rowFor(index: index, model: model)
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
