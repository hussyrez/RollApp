//
//  RollModel.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation

struct LineItem {
    let quantity: Int
    let item: MenuItem
}

struct Order
{    
    let items: [LineItem]
}

typealias Menu = [MenuItem]

struct MenuItem
{
    let name: String
    let type: String
    let price: Double
    
    let additions: [MenuAddition]
    let removals: [MenuAddition]
    
    init(name: String, type: String, price: Double) { // default struct initializer
        self.name = name
        self.type = type
        self.price = price
        
        self.additions = []
        self.removals = []
    }
}

struct MenuAddition
{
    let name: String
    let price: Double
}

extension LineItem: Decodable {
    enum Keys: String, CodingKey {
        case quantity = "quantity"
        case item = "item"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let quantity: Int = try container.decode(Int.self, forKey: .quantity)
        let item: MenuItem = try container.decode(MenuItem.self, forKey: .item)
        
        self.init(quantity: quantity, item: item)
    }
}

extension Order: Decodable {
    enum Keys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let items: [LineItem] = try container.decode([LineItem].self, forKey: .items)
        
        self.init(items: items)
    }
}

extension MenuItem: Decodable {
    enum Keys: String, CodingKey { // declaring our keys
        case name = "name"
        case type = "type"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self) // defining our (keyed) container
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        let type: String = try container.decode(String.self, forKey: .type) // extracting the data
        let price: Double = try container.decode(Double.self, forKey: .price) // extracting the data
        
        self.init(name: name, type: type, price: price) // initializing our struct
    }
}

