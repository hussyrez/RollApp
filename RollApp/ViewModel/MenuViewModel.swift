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
            item.additions.append(m)
        }
        else{
            let m = MenuAddition(name: "old", price: 2.5)
            item.additions.append(m)
        }
        
        counter += 1
        let updatedOrder = currentOrder.orderByAddingItem(item)
        for i in updatedOrder.items{
            print("\n\n\n",i,"\n\n\n")
        }
        
        OrderStorage.shared.currentOrder = updatedOrder
        let encoder = JSONEncoder()
        let str = try! encoder.encode(updatedOrder.items)
        print(String(bytes: str, encoding: .utf8) ?? "")
//        let item = menu[indexPath.row]
//        let lineItem = LineItem(quantity: 1, item: item)
////        let item = try! JSONEncoder().encode(menu[indexPath.row])
////        print(String(bytes: item, encoding: .utf8) ?? "")
//        OrderStorage.shared.currentOrder = Order(items: [lineItem])
//        print(OrderStorage().currentOrder)
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
