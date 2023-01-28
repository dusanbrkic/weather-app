//
//  ConsoleLogger.swift
//  Weather App
//
//  Created by Dusan Brkic on 18.8.22..
//

import Foundation

class ConsoleLogger: Logger {
    func logError(with description: String) {
        print(description)
    }
}
