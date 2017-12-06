//
//  BagViewModel.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/29/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit

class BagViewModel: NSObject {

    let title = "Cart"
    
    private var order: Order?
    
    init(order: Order) {
        //passed empty order initially from RollAppState
        self.order = order

        //super.init()
        
        NotificationCenter.default.addObserver(forName: OrderStorage.orderUpdatedNotification, object: nil, queue: OperationQueue.main) {
            _ in
            print("Observer invoked")
            //Write code to notify the view that the bag has been updated
        }
    }
    
    
}
