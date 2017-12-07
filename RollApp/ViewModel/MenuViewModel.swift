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
    var counter: Int = 0
    func selectedItemAtIndex(_ indexPath: IndexPath) {
        let currentOrder = OrderStorage.shared.currentOrder
        var item = menu[indexPath.row]
        
        if(counter % 2 == 0) {
            let m = MenuAddition(name: "new", price: 3.5)
            let n = MenuAddition(name: "removal new", price: Double(counter))
            item.additions.append(m)
            item.removals.append(n)
        }
        else{
            let m = MenuAddition(name: "old", price: 2.5)
            let n = MenuAddition(name: "removal new", price: Double(counter))
            item.additions.append(m)
            item.removals.append(n)
        }
        
        counter += 1
        let updatedOrder = currentOrder.orderByAddingItem(item)
//        for i in updatedOrder.items{
//            print("\n\n",i,"\n\n")
//        }
        
        OrderStorage.shared.currentOrder = updatedOrder
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let str = try! encoder.encode(updatedOrder)
//        print(String(bytes: str, encoding: .utf8) ?? "")
//        print("\n\n",updatedOrder,"\n\n")
        OrderStorage()
    }

    private func updateMenuFromRemoteConfig() {
        //grab values from remote config
        let jsonString = RemoteConfig.remoteConfig().configValue(forKey: "update").stringValue ?? ""
        
        //parse json and update values
        let data = jsonString.data(using: .utf8)!
        do {
            //list of json objects
            let menuItems = try JSONDecoder().decode([MenuItem].self, from: data) // Decoding our data
//            print(menuItems)
//            let encoder = JSONEncoder();
//            encoder.outputFormatting = .prettyPrinted
//            let menuItems2 = try! encoder.encode(menuItems)
//            print(String(bytes: menuItems2, encoding: .utf8) ?? "")
            menu = menuItems
            
            didLoadMenu()
            
        } catch {
            print("Json parsing failed . . .")
        }
        
    }
    
}
