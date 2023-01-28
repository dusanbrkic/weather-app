//
//  CityDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

struct CityDTO: Decodable {
    var name: String
    var coord: CoordinatesDTO
}
