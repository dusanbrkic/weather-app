//
//  FavoriteCityRepository.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation

protocol FavoriteCityRepository {
    func fetchAll() -> [FavoriteCityEntity]
    func saveFavoriteCity(from searchedCity: SearchedCityDTO)
}
