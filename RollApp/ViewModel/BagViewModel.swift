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
    }
    
}
