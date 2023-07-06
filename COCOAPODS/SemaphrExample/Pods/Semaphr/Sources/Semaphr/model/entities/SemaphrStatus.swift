//
//  SemaphrStatus.swift
//  Semaphr
//
//  Created by Semaphr Team on 18.07.2022.
//

import Foundation

public enum SemaphrStatus {
    case block(id: String, title: String, message: String, imageLink: String?)
    case update(id: String, title: String, message: String, dismissable: Bool, imageLink: String?)
    case notify(id: String, title: String, message: String, dismissable: Bool, imageLink: String?)
}


