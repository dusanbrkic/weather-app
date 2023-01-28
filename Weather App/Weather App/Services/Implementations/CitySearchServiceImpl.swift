//
//  CitySearchServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 19.8.22..
//

import Foundation

class CitySearchServiceImpl: CitySearchService {
    func buildURL(with prefix: String) -> URL? {
        var componentURL = URLComponents()
        componentURL.scheme = "http"
        componentURL.host = "geodb-free-service.wirefreethought.com"
        componentURL.path = "/v1/geo/cities"
        componentURL.queryItems = [
            URLQueryItem(name: "namePrefix", value: prefix),
            URLQueryItem(name: "limit", value: "5"), // pagination is possible
            URLQueryItem(name: "offset", value: "0")
        ]
        return componentURL.url
    }

    func searchCity(with prefix: String) async throws -> SearchedCitiesDTO {
        guard let validURL = buildURL(with: prefix) else {
            throw NSError()
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: validURL)
            let serializedData = try JSONDecoder().decode(SearchedCitiesDTO.self, from: data)
            return serializedData

        } catch let error {
            throw error
        }

    }
}
