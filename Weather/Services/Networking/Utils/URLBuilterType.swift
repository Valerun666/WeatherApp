//
//  URLBuilterType.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

protocol URLBuilderType {
    func build(from providerRequest: Provider) -> URL
}
