//
//  CurrentWeatherForecast.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CurrentWeatherForecast<ViewModel: CurrentWeatherViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

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

private extension CurrentWeatherForecast {
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

    func contentView(with forecast: [CurrentWeatherRowViewModel]) -> some View {
        List {
            ForEach(forecast) { model in
                Section {
                    CurrentWeatherRow(viewModel: model)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct CurrentWeatherForecast_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherForecast(viewModel: CurrentWeatherViewModel(networkClient: NetworkClient(urlBuilder: URLBuilder()),
                                                                  storage: CityPersistanceCoordinator(), builder: CityListViewBuilder()))
    }
}
