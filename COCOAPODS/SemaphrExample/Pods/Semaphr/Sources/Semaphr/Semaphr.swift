//
//  Semaphr.swift
//  Semaphr
//
//  Created by Semaphr Team on 18.07.2022.
//

import Foundation
import UIKit

public class Semaphr {

    // This is used for linking the SDK to your account
    private static var APIKey: String!

    // The manager
    private static var manager: SemaphrManager!

    // MARK: Public methods

    ///  Configures the Semaphr with the API key from the web console
    ///
    /// - Parameters:
    ///   - APIKey: The API key from your web console at https://semaphr.com
    public static func configure(APIKey: String) {
        self.APIKey = APIKey
        self.manager = SemaphrManager(apiKey: APIKey)

        checkKeys()

        manager.start()
    }

    ///  Disables the SDK, no events will be sent or mesages taken into consideration
    ///
    public static func disable() {
        manager.end()
    }

    // MARK: Private methods

    private static func checkKeys() {
        guard let APIKey = APIKey, APIKey.count > 0 else {
            fatalError("API Key is invalid. Make sure you've used the right value from the Web interface.")
        }

        self.manager.checkKeys{ success in
            if !success {
                NSLog("\n\n WARNING the bundle key combo for the Semaphr SDK is invalid. The SDK won't work.\n\n")
                manager.end()
            }
        }
    }
}
