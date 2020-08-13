//
//  CityListContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI
import Combine

enum CityListNavigationTag: String {
    case showAddCity
}

protocol CityListViewModelProtocol: ViewModel {
    var state: ViewState<[City]> { get }
    var navigationTag: CityListNavigationTag? { get set }

    func didLoad()
    func didTapAddCity()
    func remove(at offsets: IndexSet)
}

protocol CityListRouterInput {
    func showAddCity(city: PassthroughSubject<City?, Never>)
}

protocol CityListRouterOutput: Router {
    var addCity: AnyView { get set }
}
