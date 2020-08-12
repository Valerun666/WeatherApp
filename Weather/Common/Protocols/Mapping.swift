//
//  Mapping.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

protocol Mapping {
    associatedtype From
    associatedtype To

    func map(_ item: From) -> To?
}

