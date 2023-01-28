//
//  CurrentWeatherService.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

protocol CurrentWeatherService {
    func getCurrentWeather(lat: String, lon: String, appId: String) async throws -> CurrentWeatherDTO
}
