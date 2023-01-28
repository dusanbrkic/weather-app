//
//  FavoriteCityServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation

class FavoriteCityServiceImpl: FavoriteCityService {
    let favoriteCitiesRepository: FavoriteCityRepository

    init(favoriteCitiesRepository: FavoriteCityRepository) {
        self.favoriteCitiesRepository = favoriteCitiesRepository
    }

    func saveFavoriteCity(from searchedCity: SearchedCityDTO) {
        favoriteCitiesRepository.saveFavoriteCity(from: searchedCity)
    }

    func fetchAll() -> [FavoriteCityEntity] {
        return favoriteCitiesRepository.fetchAll()
    }
}
