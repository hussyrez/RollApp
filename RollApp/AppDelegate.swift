//
//  AppDelegate.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/27/17.
//  Copyright © 2017 Enabled. All rights reserved.

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = RollAppState.initialApplicationState().viewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

