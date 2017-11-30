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

struct jsonItems {
    let name: String
    let price: Double
    
    init(name: String, price: Double) { // default struct initializer
        self.name = name
        self.price = price
    }
}

extension jsonItems: Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case name = "name"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        let price: Double = try container.decode(Double.self, forKey: .price) // extracting the data
        
        self.init(name: name, price: price) // initializing our struct
    }
}

