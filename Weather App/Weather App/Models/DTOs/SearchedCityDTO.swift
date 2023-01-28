//
//  SearchedCityDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation

struct SearchedCityDTO: Decodable {
    var city: String
    var country: String
    var countryCode: String
    var latitude: Double
    var longitude: Double
    var name: String
    var region: String
}
