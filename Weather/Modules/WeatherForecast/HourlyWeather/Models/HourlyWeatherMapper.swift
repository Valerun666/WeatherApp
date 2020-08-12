//
//  HourlyWeatherMapper.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 11.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import Foundation

final class HourlyWeatherMapper: Mapping {
    private var cityList = [City]()

    func setupCityList(cityList: [City]) {
        self.cityList = cityList
    }

    func map(_ item: HourlyWeatherForecastResponse) -> HourlyWeatherForecastModel? {
        let cityName = item.timezone.components(separatedBy: "/").last
        guard let city = cityList.first(where: {$0.name == cityName}) else {
            return nil
        }

        return HourlyWeatherForecastModel(city: city, forecast: item.forecast)
    }
}
