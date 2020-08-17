//
//  AddCityContract.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 16.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import GooglePlaces

protocol AddCityViewModelProtocol: ViewModel {
    func didSelect(place: GMSPlace, onComplete: @escaping () -> Void)
}
