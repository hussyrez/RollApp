//
//  RollModel.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation

struct Order
{
    typealias LineItem = (Int, MenuItem)
    
    let items: [LineItem]
}

typealias Menu = [MenuItem]

struct MenuItem
{
    let name: String
    let price: Double
    let imageUrl: URL
    
    let additions: [MenuAddition]
    let removals: [MenuAddition]
}

struct MenuAddition
{
    let name: String
    let price: Double
}
