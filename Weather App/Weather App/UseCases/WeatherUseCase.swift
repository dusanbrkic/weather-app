//
//  WeatherUseCase.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

import Foundation

protocol WeatherUseCase {
    func getWeather(lat: String, lon: String) async throws -> WeatherDomain
}
