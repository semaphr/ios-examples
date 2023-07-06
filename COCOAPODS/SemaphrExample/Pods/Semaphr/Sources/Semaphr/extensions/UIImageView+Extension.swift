//
//  UIImageView+Extension.swift
//  Semaphr
//
//  Created by Semaphr Team on 19.07.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageFromURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                self.image = image
            })

        }).resume()
    }
}
