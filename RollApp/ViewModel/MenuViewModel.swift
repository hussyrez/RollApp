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
    
    private var menu: Menu = []
    
    var didLoadMenu: ()->() = {}
    
    var numberOfMenuItems: Int {
        return 10
        //return menu.count
    }
    
    func nameForMenuItem(at indexPath: IndexPath) -> String {
        
        //let item = menu[indexPath.row]
        //return item.name
        
        return "Get the name here!"
    }
    
    init(menuUrl: URL) {
        //OPTION1:
            //Download a JSON file
            //Parse it into the Menu (really [MenuItem])
        
        //OPTION2:
            //use cloud storage for images
            //use initial values for FireBase Remote config?
        
        
    }
    
    let title = "Menu"
    
}
