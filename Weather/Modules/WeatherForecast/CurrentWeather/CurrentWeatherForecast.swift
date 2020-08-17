//
//  CurrentWeatherForecast.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CurrentWeatherForecast<ViewModel: CurrentWeatherViewModelProtocol, Router: CurrentWeatherRouterOutput>: View {
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

private extension CurrentWeatherForecast {
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
    

    func contentView(with forecast: [CurrentWeatherRowViewModel]) -> some View {
        ZStack {
            NavigationLink(destination: router.currentWeatherDetails,
                           tag: CurrentWeatherNavigationTag.showCurrentWeatherDetails,
                           selection: $viewModel.navigationTag,
                           label: { EmptyView() })
            GeometryReader { (geometry) in
                ScrollView(width: geometry.size.width, height: geometry.size.height, viewModel: self.viewModel) {
                    self.listView(with: forecast)
                }
            }
        }
    }

    func listView(with forecast: [CurrentWeatherRowViewModel]) -> some View  {
        let withIndex = forecast.enumerated().map({ $0 })
        
        return List {
            ForEach(withIndex, id: \.element.id) { index, model in
                Section {
                    self.rowFor(index: index, model: model)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }

    func rowFor(index: Int, model: CurrentWeatherRowViewModel) -> some View {
        Button(action: {
            self.viewModel.didTapOnCell(index: index)
        }, label: {
            CurrentWeatherRow(viewModel: model)
        })
    }
}
