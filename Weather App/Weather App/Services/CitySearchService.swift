//
//  CitySearchService.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation

protocol CitySearchService {
    func searchCity(with prefix: String) async throws -> SearchedCitiesDTO
}
