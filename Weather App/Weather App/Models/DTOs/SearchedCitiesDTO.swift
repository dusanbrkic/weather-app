//
//  SearchedCitiesDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation

struct SearchedCitiesDTO: Decodable {
    var data: [SearchedCityDTO]
}
