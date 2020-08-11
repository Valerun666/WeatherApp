//
//  CityListContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import SwiftUI

protocol CityListViewModelProtocol: ViewModel {
    var state: ViewState<[City]> { get }
    var addCity: AnyView { get }

    func didLoad()
    func remove(at offsets: IndexSet)
}
