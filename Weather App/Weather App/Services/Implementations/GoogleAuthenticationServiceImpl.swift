//
//  GoogleAuthenticationServiceImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 18.8.22..
//

import Foundation
import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

 class GoogleAuthenticationServiceImpl: AuthenticationService {
     let keychainService: KeychainService

     init(keychainService: KeychainService) {
         self.keychainService = keychainService
     }

    func authenticateUser(in window: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(
            with: config,
            presenting: window
        ) { user, error in
            guard error == nil,
                  let user = user else {
                return
            }
            let authentication = user.authentication
            guard let idToken = authentication.idToken else { return }

            // Your user is signed in!
            _ = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken)

            do {
                try self.keychainService.setStringProperty(
                    authentication.accessToken,
                    key: "accessToken"
                )
            } catch {}

        }
    }

     func setupGoogleAuthListener(with action: @escaping () -> Void ) {
         _ = Auth.auth().addStateDidChangeListener { (_, user) in
             if let _ = user {
                action()
             }
         }
     }
 }
