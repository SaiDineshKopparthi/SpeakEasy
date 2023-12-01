//
//  AppDelegate.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 10/29/23.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CometChatUIKitSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        
        let uikitSettings = UIKitSettings()
        uikitSettings.set(appID: "248630e580cddc5a")
            .set(authKey: "ce31a21e1a2d53566efab4a7c67bda10c399be63")
            .set(region: "us" )
            .subscribePresenceForAllUsers()
            .build()
        CometChatUIKit.init(uiKitSettings: uikitSettings, result: {
            result in
            switch result {
            case .success(let success):
                debugPrint("Initialization completed successfully \(success)")
                break
            case .failure(let error):
                debugPrint( "Initialization failed with exception: \(error.localizedDescription)")
                break
            }
        })
        
        
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

