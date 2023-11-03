//
//  AppDelegate.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import UIKit
import CoreData
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
        //MARK: - Netfox Ignore urls
        NFX.sharedInstance().start()
        #endif
        setSession()
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        setIdentifier(deviceToken: deviceToken.hexString)
    }
    
    private func setIdentifier(deviceToken: String) {
        DefaultsManager.shared.save(val: deviceToken, key: .deviceToken)
    }
    
    private func setSession() {
        AppStartManager.shared.getSession()
    }

}

