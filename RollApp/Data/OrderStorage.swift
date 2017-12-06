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
            print("HMMM")
        }
    }
    
    private class func writeOrder(_ order: Order, path: String) {
        //TODO: Write order to path
        let fileUrl = URL(fileURLWithPath: path)
        let tempOrder = try! JSONEncoder().encode(order)
        let temp2 = String(bytes: tempOrder, encoding: .utf8) ?? ""
//        print(temp2)
        try! temp2.write(to: fileUrl, atomically: true, encoding: .utf8)
    }
    
    private class func readOrder(_ path: String) -> Order {
        //TODO: Load the order from file at path and return
//        let fileUrl = URL(fileURLWithPath: path)
//        let text = try! String(contentsOf: fileUrl, encoding: .utf8)
//        print(text)
        print("reading every time ")
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
