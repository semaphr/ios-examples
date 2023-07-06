//
//  BaseService.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation

public typealias JSONClosure = (_ success: Bool, _ json: [String: Any]?) -> Void

open class BaseService: NSObject {
    
    private let backgroundConfig = URLSessionConfiguration.background(withIdentifier: NSUUID().uuidString)
    private let config = URLSessionConfiguration.default
    private let delegateQueue = OperationQueue()
    
    private var session: URLSession!
    private var backgroundSession: URLSession!
    
    private var cachedCompletion: JSONClosure? = nil
    
    override init() {
        delegateQueue.name = "background-queue-semaphr"
        config.sessionSendsLaunchEvents = true
        
        super.init()
        
        session = URLSession(configuration: config, delegate: nil, delegateQueue: delegateQueue)
        backgroundSession = URLSession(configuration: backgroundConfig, delegate: self, delegateQueue: delegateQueue)
    }
    
    func makeRequest(background: Bool = false, URLRequest: URLRequest, completion: @escaping JSONClosure) {
        if background {
            cachedCompletion = completion
            
            let task = backgroundSession.downloadTask(with: URLRequest)
            task.resume()
       
        } else {
            let task = session.dataTask(with: URLRequest) { (data, urlResponse, error) in
                guard error == nil, let data = data, let http = urlResponse as? HTTPURLResponse else {
                    completion(false, nil)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        DispatchQueue.main.async {
                            // Success
                            completion(http.statusCode == 200, json)
                        }
                        return
                    }

                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                        DispatchQueue.main.async {
                            // Success
                            completion(http.statusCode == 200, ["value":json])
                        }
                        return
                    }
                    
                } catch _ {}
                
                completion(false, nil)
            }
            
            task.resume()
        }
    }
}


extension BaseService: URLSessionDownloadDelegate {

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        defer {
            cachedCompletion = nil
        }
        
        cachedCompletion?(false, nil)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        defer {
            cachedCompletion = nil
        }
        
        do {
            let data = try Data(contentsOf: location)
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                
                // Success
                cachedCompletion?(true, json)
                return
            }
            
        } catch {}
        
        cachedCompletion?(false, nil)
    }
}

