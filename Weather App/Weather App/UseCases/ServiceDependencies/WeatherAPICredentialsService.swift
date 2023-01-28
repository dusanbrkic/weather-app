//
//  WeatherAPICredentialsService.swift
//  Weather App
//
//  Created by Dusan Brkic on 17.8.22..
//

protocol WeatherAPICredentialsService {
    func setupUserCredentials() throws
    func getUserCredentials() throws -> String
}
