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
        static let APIKey = "7d5ba78a2e8314bd199734e88beb96f543516531a403cd049c1b9a8f3d9e69f572315eb12552ddc20334a52a6197f08864214fdf18fd1de99cdfdc946ce662a8"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Semaphr.configure(APIKey: Constants.APIKey)

        return true
    }

}

