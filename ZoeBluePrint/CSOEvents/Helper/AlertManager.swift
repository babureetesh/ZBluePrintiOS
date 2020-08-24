//
//  AlertManager.swift
//  EliteSISSwift
//
//  Created by Vivek on 13/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit


class AlertManager {
    
    var rootWindow: UIWindow!
    static var shared = AlertManager()
    
    
    func showAlertWith(title: String,message: String) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (UIAlertAction) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
//                guard window.rootViewController?.presentedViewController == alert else { return}
//                window.rootViewController?.dismiss(animated: true, completion: nil)
//            })
//        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))

        
//        window.backgroundColor = .clear
//        window.rootViewController = UIViewController()
//        AlertManager.shared.rootWindow = UIApplication.shared.windows.first
//        window.windowLevel = UIWindow.Level.alert
//        window.makeKeyAndVisible()
        if let window = UIApplication.shared.keyWindow {
             window.rootViewController?.present(alert, animated: true, completion: nil)
        }
       
                    
    }
    
    
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .clear
        window.rootViewController = UIViewController()
        AlertManager.shared.rootWindow = UIApplication.shared.windows.first
        window.windowLevel = UIWindow.Level.alert
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                guard window.rootViewController?.presentedViewController == alert else { return}
                window.rootViewController?.dismiss(animated: true, completion: nil)
            })
        })
    }
}
