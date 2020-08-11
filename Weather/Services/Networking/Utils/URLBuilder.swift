//
//  URLBuilder.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class URLBuilder: URLBuilderType {
    func build(from providerRequest: Provider) -> URL {
        let components = providerRequest.params.map { URLQueryItem(name: $0.name, value: $0.value) }
        var urlComponents = URLComponents(url: providerRequest.baseUrl.appendingPathComponent(providerRequest.route), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = components
        return urlComponents?.url ?? providerRequest.baseUrl
    }
}
