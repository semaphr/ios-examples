//
//  AlertHelper.swift
//  Semaphr
//
//  Created by Semaphr Team on 18.07.2022.
//

import Foundation
import UIKit

class AlertHelper {
    
   static func displayMessageOnTopOfEverything(_ message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            // remove the window
            alertController.xxx_window?.isHidden = true
            alertController.xxx_window = nil
        }
        
        alertController.addAction(action)
        alertController.showOnANewWindow()
    }
}
