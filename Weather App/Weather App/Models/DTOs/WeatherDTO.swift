//
//  WeatherDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

struct WeatherDTO: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
