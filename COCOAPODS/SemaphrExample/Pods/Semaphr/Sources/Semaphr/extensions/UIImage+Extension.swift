//
//  UIImage+Extension.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import UIKit

extension UIImage {

    static func frameworkImage(named: String) -> UIImage? {
        let frameworkBundle = Bundle.framework
        guard let imageBundle = frameworkBundle.url(forResource: "semaphr-assets",
                                         withExtension: "bundle") else {
               return nil

        }

        
        let image = UIImage.init(named: named, in: Bundle(url: imageBundle), with: nil)

        return image
    }
}

