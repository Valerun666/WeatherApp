//
//  CurrentWeatherDetails.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 17.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI


struct CurrentWeatherDetails<ViewModel: CurrentWeatherDetailsViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
            .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
    }
}

private extension CurrentWeatherDetails {
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

    func contentView(with weatherForecast: CurrentWeatherForecastViewModel) -> some View {
        CurrentWeatherForecastDetailsView(viewModel: weatherForecast)
    }
}
