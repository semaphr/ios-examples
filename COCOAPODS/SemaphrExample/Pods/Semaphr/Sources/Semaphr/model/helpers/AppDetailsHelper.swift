//
//  AppDetailsHelper.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation
import UIKit

class AppDetailsHelper {
    
    private struct Constants {
        static let bundleShort = "CFBundleShortVersionString"
        static let bundleVersion = "CFBundleVersion"
        static let bundleIdentifier = "CFBundleIdentifier"
        
        static let unknownValue = "unknown"
    }
    
    // MARK: Methods
    
    static func getAppDetails() -> AppDetails {
        let version: String = Bundle.main.object(forInfoDictionaryKey: Constants.bundleShort) as? String ?? Constants.unknownValue
        let build: String = Bundle.main.object(forInfoDictionaryKey: Constants.bundleVersion) as? String ?? Constants.unknownValue
        let bundle = getBundleID()
        
        let device = UIDevice.modelName
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? Constants.unknownValue
        
        return AppDetails(version: version, build: build, bundle: bundle, device: device, deviceID: deviceID)
    }
    
    
    static func getBundleID() -> String {
        let bundle: String = Bundle.main.object(forInfoDictionaryKey: Constants.bundleIdentifier) as? String ?? Constants.unknownValue
        
        return bundle
    }
}
