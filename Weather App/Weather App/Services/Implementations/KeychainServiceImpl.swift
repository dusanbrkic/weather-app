//
//  KeychainServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 22.8.22..
//

import Foundation
import KeychainAccess

class KeychainServiceImpl: KeychainService {
    let keychain: Keychain

    init(serviceName: String) {
        keychain = Keychain(service: serviceName)
    }

    func getStringProperty(by key: String) throws -> String? {
        do {
            return try keychain.get(key)
        } catch let error {
            throw error
        }
    }

    func setStringProperty(_ value: String, key: String) throws {
        do {
            try keychain.set(value, key: key)
        } catch let error {
            throw error
        }
    }

}
