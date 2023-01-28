//
//  HourlyForecastResponse.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

struct HourlyForecastDTO: Decodable {
    var city: CityDTO
    var forecasts: [ForecastDTO]

    enum CodingKeys: String, CodingKey {
        case forecasts = "list",
             city

    }
}
