//
//  WeatherIconServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 12.8.22..
//

import Foundation

class WeatherIconServiceImpl: WeatherIconService {
    func buildURL(with iconCode: String) -> URL? {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "openweathermap.org"
        componentURL.path = "/img/wn/\(iconCode)@2x.png"
        return componentURL.url
    }

    func getWeatherIcon(for icon: String) async throws -> Data {
        guard let validURL = buildURL(with: icon) else {
            throw NSError()
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: validURL)
            return data
        } catch let error {
            throw error
        }
    }
}
