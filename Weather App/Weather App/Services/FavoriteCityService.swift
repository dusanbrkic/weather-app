//
//  FavoriteCityService.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation

protocol FavoriteCityService {
    func fetchAll() -> [FavoriteCityEntity]
    func saveFavoriteCity(from searchedCity: SearchedCityDTO)
}
