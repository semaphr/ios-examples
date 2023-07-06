//
//  UIViewController+Extension.swift
//  Semaphr
//
//  Created by Semaphr Team on 18.07.2022.
//

import UIKit

fileprivate class ContainerViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIViewController {
    
    private struct AssociatedKeys {
        static var activityIndicator = "xxx_window"
    }
    
    var xxx_window: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIWindow
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.activityIndicator,
                    newValue as UIWindow?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    func removeShownWindow() {
        xxx_window?.isHidden = true
        xxx_window = nil
    }

    func showOnANewWindow() {
        var rootWindow: UIWindow?
        if #available(iOS 13.0, *) {
            
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                
                return
            }
            
            xxx_window = UIWindow(windowScene: scene)
            rootWindow = scene.keyWindow
        } else {
            // Fallback on earlier versions
            xxx_window = UIWindow(frame: UIScreen.main.bounds)
            rootWindow = UIApplication.shared.keyWindow
        }
        
        let containerVC = ContainerViewController()
        containerVC.view.backgroundColor = UIColor.clear
        xxx_window?.rootViewController = containerVC
        
        if let topWindow = rootWindow {
            xxx_window?.windowLevel = topWindow.windowLevel + 1
            
            xxx_window?.makeKeyAndVisible()
            modalPresentationStyle = .overFullScreen
            xxx_window?.rootViewController?.present(self, animated: false, completion: nil)
        }
    }
}

