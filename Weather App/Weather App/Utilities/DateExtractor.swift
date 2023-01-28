//
//  DateExtractor.swift
//  Weather App
//
//  Created by Dusan Brkic on 16.8.22..
//

import Foundation

class DateExtractor {
    func getHours(from dateStr: String) throws -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH"

        guard let date = dateFormatterGet.date(from: dateStr) else {
            throw NSError()
        }
        let hours = dateFormatterPrint.string(from: date)
        return String(hours)
    }
}
