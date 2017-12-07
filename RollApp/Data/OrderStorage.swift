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
//        print("\nWrite Function After Update: \n",order,"\n\n")
        let fileUrl = URL(fileURLWithPath: path)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let tempOrder = try! encoder.encode(order)
        let temp2 = String(bytes: tempOrder, encoding: .utf8) ?? ""
//        print(temp2)
        try! temp2.write(to: fileUrl, atomically: true, encoding: .utf8)
    }
    
    private class func readOrder(_ path: String) -> Order {
        //TODO: Load the order from file at path and return
        let fileUrl = URL(fileURLWithPath: path)
        let text = try! String(contentsOf: fileUrl, encoding: .utf8)
        print("\nRead Function Input From File\n",text,"\n\n")
        
        let deco = JSONDecoder()
        let da = text.data(using: .utf8)
        let newOrder = try! deco.decode(Order.self, from: da!)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let str = try! encoder.encode(newOrder)
        print("\nRead Function After Decoding: \n", String(bytes: str, encoding: .utf8) ?? "", "\n")
        
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
