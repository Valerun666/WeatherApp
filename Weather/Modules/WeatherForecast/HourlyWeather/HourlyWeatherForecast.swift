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
        contentView
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
        let withIndex = forecast.enumerated().map({ $0 })

        return ZStack {
            NavigationLink(destination: router.hourlyWeatherDetails,
                           tag: HourlyWeatherNavigationTag.showHourlyWeatherDetails,
                           selection: $viewModel.navigationTag,
                           label: { EmptyView() })
            List {
                ForEach(withIndex, id: \.element.city) { index, model in
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

    func rowFor(index: Int, model: HourlyWeatherSectionViewModel) -> some View {
        Button(action: {
            self.viewModel.didTapOnCell(index: index)
        }, label: {
            Text(model.city)
        })
    }
}

struct HourlyWeatherForecast_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
