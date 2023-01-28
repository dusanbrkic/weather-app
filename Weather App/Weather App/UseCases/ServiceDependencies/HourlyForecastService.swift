//
//  HourlyForecastService.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

protocol HourlyForecastService {
    func getHourlyForecast(lat: String, lon: String, appId: String) async throws -> HourlyForecastDTO
}
