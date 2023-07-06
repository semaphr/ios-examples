//
//  Mappers.swift
//  Semaphr
//
//  Created by Semaphr Team on 14.10.2022.
//

import Foundation

class Mappers {
    
    private struct Constants {
        static let version = "version"
        static let build = "build"
        static let deviceType = "device_type"
        static let deviceIdentifier = "device_identifier"
        static let platform = "platform"
        static let identifier = "identifier"
        
        static let iOS = "ios"
        
        static let rule = "rule"
        static let id = "id"
        static let title = "title"
        static let message = "message"
        static let ruleType = "rule_type"
        static let dismissible = "dismissible"
    }
    
    
    static func appDetailsToDict(_ appDetails: AppDetails) -> Data? {
        let dict =  [Constants.version: appDetails.version,
                     Constants.build: appDetails.build,
                     Constants.deviceType: appDetails.device,
                     Constants.deviceIdentifier: appDetails.deviceID,
                     Constants.identifier: appDetails.bundle,
                     Constants.platform: Constants.iOS]
        
        return dictToData(dict)
    }
    
    static func identifierToDict(_ value: String) -> Data? {
        let dict =  [Constants.identifier: value]
        
        return dictToData(dict)
    }
    
    static func responseToStatus(_ dict: [String: Any]) -> SemaphrStatus? {
        guard let rule = dict[Constants.rule] as? [String: Any],
              let id = rule[Constants.id] as? Int,
              let title = rule[Constants.title] as? String,
              let message = rule[Constants.message] as? String,
              let dismissable = rule[Constants.dismissible] as? Bool,
              let ruleType = rule[Constants.ruleType] as? String else {
            
            return nil
        }
        
        let idStr = "\(id)"
        
        switch ruleType {
        case "notify":
            return SemaphrStatus.notify(id: idStr, title: title, message: message, dismissable: dismissable, imageLink: nil)
            
        case "block":
            return SemaphrStatus.block(id: idStr, title: title, message: message, imageLink: nil)
            
        case "update":
            return SemaphrStatus.update(id: idStr, title: title, message: message, dismissable: dismissable, imageLink: nil)
            
        default:
            return nil
        }
    }
    
    // MARK: Private methods
    
    private static func dictToData(_ dict: [String: Any]) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
