//
//  ITunesService.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation

typealias AppleAppIDClosure = (_ appID: String?) -> Void

class ITunesService: BaseService {
    
    private struct Constants {
        static let results = "results"
        static let trackID = "trackId"
        
        static let endpoint = "http://itunes.apple.com/lookup?bundleId="
    }
    
    func getAppleAppID(details: AppDetails, completion: @escaping AppleAppIDClosure) {
        guard let url = URL(string: Constants.endpoint + details.bundle) else {
            completion(nil)
            return
        }

        let request = URLRequest(url: url)
        makeRequest(URLRequest: request) { success, json in
            if let json = json,
               let resultsArray = json[Constants.results] as? [[String: Any]] {
                
                // Search trought the results, first found, first served
                for result in resultsArray {
                    if let trackID = result[Constants.trackID] as? Int {
                        
                        completion("\(trackID)")
                        return
                    }
                }
            }
        }
        
        // Failed case
        completion(nil)
    }
}
