//
//  Extension+String.swift
//  Weather App
//
//  Created by Dusan Brkic on 18.8.22..
//

import Foundation

extension String {
    func localized(with comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

    func localizedPlural(with comment: String? = nil, numberOfItems: Int) -> String {
        let format = NSLocalizedString(self, comment: "")
        let message = String.localizedStringWithFormat(format, numberOfItems)
        return String.localizedStringWithFormat(format, numberOfItems)
    }
}
