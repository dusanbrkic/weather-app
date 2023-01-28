//
//  HourlyForecastServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

class HourlyForecastServiceImpl: HourlyForecastService {
    let units = "metric" // for celsius

    func buildURL(lat: String, lon: String, appId: String) -> URL? {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.openweathermap.org"
        componentURL.path = "/data/2.5/forecast"
        componentURL.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: appId),
            URLQueryItem(name: "units", value: units)
        ]
        return componentURL.url
    }

    func getHourlyForecast(lat: String, lon: String, appId: String) async throws -> HourlyForecastDTO {
        guard let validURL = buildURL(lat: lat, lon: lon, appId: appId) else {
            throw NSError()
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: validURL)
            let serializedData = try JSONDecoder().decode(HourlyForecastDTO.self, from: data)
            return serializedData

        } catch let error {
            throw error
        }
    }
}
