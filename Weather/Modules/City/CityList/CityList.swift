//
//  CityList.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

struct CityList<ViewModel: CityListViewModelProtocol>: View {
    @State private var isPresented = false
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
        .navigationBarItems(trailing:
            Button("Add City") {
                self.isPresented = true
            }.sheet(isPresented: $isPresented) {
                self.viewModel.addCity
            }
        ).onAppear(perform: viewModel.didLoad)
    }
}

private extension CityList {
    var contentView: some View {
        switch viewModel.state {
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true), style: .large))
        case .data(let cities):
            return AnyView(contentView(with: cities))
        case .error:
            return AnyView(Text("Error"))
        case .empty:
            return AnyView(Text("No yet any city. Please add the city to the list"))
        }
    }

    func contentView(with cities: [City]) -> some View {
        List {
            ForEach(cities) { model in
                CityRow(city: model)
            }.onDelete(perform: viewModel.remove)
        }
        .listStyle(GroupedListStyle())
    }
}
