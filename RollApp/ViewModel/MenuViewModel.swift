//
//  MenuViewModel.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class MenuViewModel: NSObject {
    
    var didLoadMenu: ()->() = {}
    
    var menu: [MenuItem] = []
    var numberOfMenuItems: Int {
        return menu.count
    }
    
    let title = "Menu"
    
    func nameForMenuItem(at indexPath: IndexPath) -> String {
        
        let item = menu[indexPath.row]
        return item.name
    }
    
    func viewAppeared() {
        //Update from cache
        updateMenuFromRemoteConfig()
        
        //Update again from server
        fetchRemoteConfig {
            [weak self] in
            self?.updateMenuFromRemoteConfig()
        }
    }
    
    func selectedItemAtIndex(_ indexPath: IndexPath) {
        //TODO: Add to bag
        
        
    }
    
    private func updateMenuFromRemoteConfig() {
        //grab values from remote config
        //?? to check if it exists, otherwise empty string as default
        let jsonString = RemoteConfig.remoteConfig().configValue(forKey: "update").stringValue ?? ""
        //        parse json and update values
        let data = jsonString.data(using: .utf8)!
        do {
            //list of json objects
            let menuItems = try JSONDecoder().decode([MenuItem].self, from: data) // Decoding our data
            
            menu = menuItems
            
            //create a list of menu items from json and update viewmodel
            
            didLoadMenu()
        } catch {
            print("Json parsing failed . . .")
        }
        
    }
    
}
