//
//  BackendService.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation

typealias SemaphrStatusCompletion = (_ status: SemaphrStatus?) -> Void

class APIService: BaseService {
    
    private struct Constants {
        struct URLs {
            static let endpoint = "https://api.semaphr.com/api/v1"
            
            static let checkVersionPath = "/validate"
            static let status = "/status"
        }
        
        struct Headers {
            static let apiKey = "PROJECT-KEY"
        }
    }
    
    private let apiKey: String
    
    // MARK: Lifecycle
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: Merthods
    
    func getCurrentStatus(appDetails: AppDetails, completion: @escaping SemaphrStatusCompletion) {
        var request = urlRequestWithAuthHeaders(path: Constants.URLs.status)
        request.httpMethod = "POST"
        request.httpBody = Mappers.appDetailsToDict(appDetails)
        
        makeRequest(URLRequest: request) { success, json in
            guard let json = json, success, let status = Mappers.responseToStatus(json) else {
                completion(nil)
                return
            }
            
            completion(status)
        }
    }
    
    func checkKeys(identifier: String, completion: @escaping SemaphrBoolCompletion) {
        var request = urlRequestWithAuthHeaders(path: Constants.URLs.checkVersionPath)
        request.httpMethod = "POST"
        request.httpBody = Mappers.identifierToDict(identifier)
        
        makeRequest(URLRequest: request) { success, json in
            guard let _ = json, success else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    // MARK: Private methods
    
    private func urlRequestWithAuthHeaders(path: String) -> URLRequest {
        let endpoint = Constants.URLs.endpoint + path
        let url = URL(string: endpoint)!
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: Constants.Headers.apiKey)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
