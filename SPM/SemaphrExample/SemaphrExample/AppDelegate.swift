//
//  AppDelegate.swift
//  SemaphrExample
//
//  Created by Dragos Dobrean on 05.07.2023.
//

import UIKit
import Semaphr

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum Constants {
        static let APIKey = "d91bfa03ef31c97870fb137265d3ef5f87e4bc79068cd1307dc3987ef4b735bd4966eaab59f53dfd746a134e530f111b51eec25ae3cc11ea86b7ca89c591f704"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Configure the semaphr SDK
        Semaphr.configure(APIKey: Constants.APIKey)

        // Other configs you have in your app...
        
        return true
    }
}

