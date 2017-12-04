//
//  OrderStorage.swift
//  RollApp
//
//  Created by Azil Hasnain on 12/4/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation

class OrderStorage {
    
    static let orderUpdatedNotification = Notification.Name(rawValue: "OrderUpdatedNotification")
    
    static var shared = OrderStorage()
    
    init() {
        currentOrder = OrderStorage.readOrder(OrderStorage.defaultOrderLocation)
    }
    
    var currentOrder = Order(items: []) {
        didSet {
            //Notify that the order has changed
            NotificationCenter.default.post(name: OrderStorage.orderUpdatedNotification, object: self)
            
            //Write the new order to disk
            OrderStorage.writeOrder(currentOrder, path: OrderStorage.defaultOrderLocation)
        }
    }
    
    private class func writeOrder(_ order: Order, path: String) {
        //TODO: Write order to path
    }
    
    private class func readOrder(_ path: String) -> Order {
        //TODO: Load the order from file at path and return
        return Order(items: [])
    }
 
    private static var defaultOrderLocation: String {
        get {
            if let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                return (documents as NSString).appendingPathComponent("order.json")
            }
            
            fatalError("User has no documents folder. Crash app")
        }
    }
}
