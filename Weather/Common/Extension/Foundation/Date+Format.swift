//
//  Date+Format.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation


extension Date {
    enum DateFormat {
        case hourlyDate

        var value: String {
            switch self {
            case .hourlyDate: return "MMM d, h:mm a"
            }
        }
    }

    func stringIn(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
