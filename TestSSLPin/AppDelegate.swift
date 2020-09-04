//
//  AppDelegate.swift
//  TestSSLPin
//
//  Created by Mac on 04.09.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import UIKit
import TrustKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        TrustKit.setLoggerBlock { (message) in
            print("TrustKit log: \(message)")
        }
        
        let trustKitConfig: [String: Any] = [
            kTSKSwizzleNetworkDelegates: false,
            kTSKPinnedDomains: [
                "yahoo.com": [
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: true,
                    
                    // Invalid pins to demonstrate a pinning failure
                    kTSKPublicKeyHashes: [
                         "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=",
                         "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="
                    ],
                    kTSKReportUris:["https://overmind.datatheorem.com/trustkit/report"],
                ],
                "www.google.com": [
                    kTSKEnforcePinning: true,
                    
                    // Valid pin and backup pin
                    kTSKPublicKeyHashes: [
                        "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
                        "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="
                    ]
                    //kTSKReportUris:["https://overmind.datatheorem.com/trustkit/report"],
                ]
            ]]
        
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
        
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

