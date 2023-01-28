//
//  WeatherIconService.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

import Foundation

protocol WeatherIconService {
    func getWeatherIcon(for icon: String) async throws -> Data
}
