//
//  MainWeatherDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

struct MainWeatherDTO: Decodable {
    var temp: Float
    var feelsLike: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Int
    var humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp,
             feelsLike = "feels_like",
             tempMin = "temp_min",
             tempMax = "temp_max",
             pressure,
             humidity
    }
}
