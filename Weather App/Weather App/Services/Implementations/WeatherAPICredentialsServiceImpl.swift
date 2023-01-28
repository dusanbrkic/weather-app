//
//  WeatherAPICredentialsService.swift
//  Weather App
//
//  Created by Dusan Brkic on 17.8.22..
//

import Foundation

class WeatherAPICredentialsServiceImpl: WeatherAPICredentialsService {
    let appIdKey = "appid"
    let appIdValue = "cf58895736902ba5a1d56d55e4639b49"
    let userDefaultsKey = "CredentialsSetup"
    let keychainService: KeychainService

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    func setupUserCredentials() throws {
        if !UserDefaults.standard.bool(forKey: userDefaultsKey) {
            UserDefaults.standard.set(true, forKey: userDefaultsKey)
            do {
                try keychainService.setStringProperty(appIdKey, key: appIdValue)
            } catch {
                throw CredentialsError.setupError
            }
        }
    }

    func getUserCredentials() throws -> String {
        do {
            guard let credentials = try keychainService.getStringProperty(by: appIdKey) else {
                throw CredentialsError.getError
            }
            return credentials
        } catch {
            throw CredentialsError.getError
        }

    }
}
