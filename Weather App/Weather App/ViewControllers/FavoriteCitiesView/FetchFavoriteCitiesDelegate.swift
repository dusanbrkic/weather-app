//
//  FetchFavoriteCitiesDelegate.swift
//  Weather App
//
//  Created by Dusan Brkic on 23.8.22..
//

import Foundation

protocol FetchFavouriteCitiesDelegate: AnyObject {
    func fetchWeather(for favouriteCity: FavoriteCityEntity,
                      completion: @escaping (WeatherDomain) -> Void)
}
