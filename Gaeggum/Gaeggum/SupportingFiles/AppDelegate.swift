//
//  AppDelegate.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        // Override point for customization after application launch.
        
        let loadedUserInfo = UserInfo.loadUserInfo()
        let loadedCareer = loadedUserInfo?.career
        if let loadedCareer = loadedCareer {
            // localDB에 이미 career 있을 시
        } else {
            // 이전 검사한 이력이 없을 시
            print("초기 화면", loadedUserInfo, loadedCareer)
            
            let storyboard = UIStoryboard(name: "InitialTest", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialTestVC")
//            initialViewController.setRootViewController(rootViewController: initialViewController)
            self.window?.rootViewController = initialViewController
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

