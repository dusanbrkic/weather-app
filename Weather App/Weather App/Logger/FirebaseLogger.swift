//
//  FirebaseLogger.swift
//  Weather App
//
//  Created by Dusan Brkic on 18.8.22..
//

import Foundation
import Firebase
import FirebaseCrashlytics

class FirebaseLogger: Logger {

    let instance: Crashlytics

    init(instance: Crashlytics) {
        self.instance = instance
    }

    func logError(with description: String) {
        instance.log(description)
    }

}
