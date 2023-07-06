//
//  Bundle+Extension.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation

extension Bundle {
    
    static var framework: Bundle {
        get {
            let bundle = Bundle(for: Semaphr.self)
        
            return bundle
        }
    }
}
