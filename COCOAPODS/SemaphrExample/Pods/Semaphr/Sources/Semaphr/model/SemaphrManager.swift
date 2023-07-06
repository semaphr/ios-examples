//
//  SemaphrManager.swift
//  Semaphr
//
//  Created by Semaphr Team on 20.07.2022.
//

import Foundation
import UIKit

typealias SemaphrBoolCompletion = (_ value: Bool) -> Void

class SemaphrManager {
    
    private var apiService: APIService
    private var currentStatus: SemaphrStatus?
    private var currentlyDisplayedViewController: UIViewController?
    
    private let apiKey: String
    
    // MARK: Lifecycle
    
    init(apiKey: String) {
        self.apiKey = apiKey
        self.apiService = APIService(apiKey: apiKey)
    }
    
    // MARK: Methods
    
    func start() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    func end() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func checkKeys(completion: @escaping SemaphrBoolCompletion) {
        self.apiService.checkKeys(identifier: AppDetailsHelper.getBundleID(), completion: completion)
    }

    // MARK: App lifecycle

    @objc func applicationDidBecomeActive() {
        getCurrentStatus()
    }
    
    // MARK: Private methods
    
    private func getCurrentStatus() {
        let appDetails = AppDetailsHelper.getAppDetails()
        
        apiService.getCurrentStatus(appDetails: appDetails) { status in
            if let status = status {
                self.handleStatus(status: status)
            }
        }
    }
    
    private func handleStatus(status: SemaphrStatus) {
        currentStatus = status
        
        currentlyDisplayedViewController?.removeShownWindow()
        
        let vc = SemaphrMessageViewController(status: status)
        vc.showOnANewWindow()
        
        currentlyDisplayedViewController = vc
    }
}
