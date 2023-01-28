//
//  KeychainService.swift
//  Weather App
//
//  Created by Dusan Brkic on 22.8.22..
//

import Foundation

protocol KeychainService {
    func getStringProperty(by key: String) throws -> String?
    func setStringProperty(_ value: String, key: String) throws
}
