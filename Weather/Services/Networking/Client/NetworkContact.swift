//
//  NetworkContact.swift
//  Weather
//
//  Created by Valerii Teptiuk on 09.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation
import Combine

enum NetworkErrorType: Error {
    case decoding
    case urlEncoding
}

struct NetworkParam {
    let name: String
    let value: String
}

protocol NetworkClientType {
    func execute<Request: Provider, T: Decodable>(request: Request, with type: T.Type) -> AnyPublisher<T, Error>
}
