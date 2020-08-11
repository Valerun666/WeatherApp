//
//  NetworkClient.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import Combine

final class NetworkClient: NetworkClientType {
    private let urlBuilder: URLBuilderType

    init(urlBuilder: URLBuilderType) {
        self.urlBuilder = urlBuilder
    }

    func execute<Request: Provider, T: Decodable>(request: Request, with type: T.Type) -> AnyPublisher<T, Error> {
        let url = urlBuilder.build(from: request)
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
