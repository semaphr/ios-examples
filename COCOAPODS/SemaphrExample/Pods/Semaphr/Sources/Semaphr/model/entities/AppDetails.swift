//
//  AppDetails.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation

struct AppDetails: Codable {
    let version: String
    let build: String
    let bundle: String
    let device: String
    let deviceID: String
    
    private enum CodingKeys : String, CodingKey {
        case version, build, bundle, device, deviceID
    }
}
