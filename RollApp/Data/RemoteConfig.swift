//
//  RemoteConfig.swift
//  RollApp
//
//  Created by Azil Hasnain on 12/4/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import Firebase

func setupRemoteConfigDefaults() {
    let defaultValue =
        [
            "update" :
                """
                [
                    {
                    "name" : "Potato Roll",
                    "type" : "vegan",
                    "price" :  5
                    },
                    {
                    "name" : "Beef Roll",
                    "type" : "non-vegan",
                    "price" : 7
                    }
                ]
                """ as NSObject
    ]
    
    RemoteConfig.remoteConfig().setDefaults(defaultValue)
}

func fetchRemoteConfig(completion: (()->())? = nil) {
    
    let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
    RemoteConfig.remoteConfig().configSettings = debugSettings!
    
    //NOTE: throttle in deployment by keeping it 0!! change it later
    RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) {
        (status, error) in
        
        guard error == nil else {
            print("FAILED connection!")
            return
        }
        
        print("SUCCESSFULL connection!")
        
        RemoteConfig.remoteConfig().activateFetched()
    
        completion?()
    }
}
