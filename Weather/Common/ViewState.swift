//
//  ViewState.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

enum ViewState<T> {
    case empty
    case loading
    case data(T)
    case error
}

