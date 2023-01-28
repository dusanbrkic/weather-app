//
//  ForecastDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

struct ForecastDTO: Decodable {
    var weather: [WeatherDTO]
    var main: MainWeatherDTO
    var dateTime: String

    enum CodingKeys: String, CodingKey {
        case
            main,
            weather,
            dateTime = "dt_txt"
    }
}
