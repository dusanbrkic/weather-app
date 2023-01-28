//
//  AlertController.swift
//  Weather App
//
//  Created by Dusan Brkic on 11.8.22..
//

import UIKit

class UIAlertBuilder {
    func buildRetryableAlert(
        with title: String,
        and description: String,
        action: @escaping () -> Void) -> UIAlertController {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
            let retry = UIAlertAction(title: "Retry", style: .default) { _ in
                action()
            }
            alert.addAction(dismiss)
            alert.addAction(retry)
            return alert
        }

    func buildDismissibleAlert(with title: String, and description: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismiss)
        return alert
    }
}
