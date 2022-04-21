//
//  UIViewController+extension.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/22.
//
import UIKit

extension UIViewController {
    var rootViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                return sceneDelegate.window?.rootViewController
            }
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                return appDelegate.window?.rootViewController
            }
        }
        
        return UIViewController()
    }
    
    func setRootViewController(rootViewController: UIViewController) {
        if #available(iOS 13.0, *) {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = rootViewController
            }
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = rootViewController
            }
        }
        
    }
}

