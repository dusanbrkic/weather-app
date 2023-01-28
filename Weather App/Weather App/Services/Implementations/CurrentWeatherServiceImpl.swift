//
//  CurrentWeatherServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 10.8.22..
//

import Foundation

class CurrentWeatherServiceImpl: CurrentWeatherService {

    let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    let units = "metric" // for celsius

    private func buildURL(lat: String, lon: String, appId: String) -> URL? {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.openweathermap.org"
        componentURL.path = "/data/2.5/weather"
        componentURL.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: appId),
            URLQueryItem(name: "units", value: units)
        ]

        return componentURL.url
    }

    func getCurrentWeather(lat: String, lon: String, appId: String) async throws -> CurrentWeatherDTO {

        guard let validURL = buildURL(lat: lat, lon: lon, appId: appId) else {
            self.logger.logError(with: "I could not get a valid URL")
            throw NSError()
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: validURL)
            let serializedData = try JSONDecoder().decode(CurrentWeatherDTO.self, from: data)
            return serializedData

        } catch let error {
            throw error
        }
    }
}
