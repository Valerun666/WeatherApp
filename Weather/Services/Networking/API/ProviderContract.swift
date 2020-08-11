//
//  ProviderContract.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

import Foundation

protocol Provider {
    var baseUrl: URL { get }
    var route: String { get }
    var params: [NetworkParam] { get }
}

extension Provider {
    var baseUrl: URL {
        URL(string: "https://api.openweathermap.org")!
    }
}
