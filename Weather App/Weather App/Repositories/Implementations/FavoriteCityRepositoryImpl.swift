//
//  FavoriteCityRepositoryImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation

class FavoriteCityRepositoryImpl: FavoriteCityRepository {

    let instance: DatabaseCRUD

    init(instance: DatabaseCRUD) {
        self.instance = instance
    }

    func saveFavoriteCity(from searchedCity: SearchedCityDTO) {
        self.instance.saveFavouriteCity(with: searchedCity)
    }

    func fetchAll() -> [FavoriteCityEntity] {
        return self.instance.fetchAll()
    }
}
