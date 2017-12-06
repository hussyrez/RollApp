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

extension Order {
    private func lineItemForMenuItem(_ item: MenuItem) -> LineItem? {
        return items.first {
            lineItem -> Bool in

            return lineItem.item == item
        }
    }
    
    func orderByAddingItem(_ item: MenuItem) -> Order {
        var newItems = items
        
        if let existingLineItem = lineItemForMenuItem(item) {
            newItems.append(LineItem(quantity: existingLineItem.quantity + 1, item: item))
        } else {
            newItems.append(LineItem(quantity: 1, item: item))
        }
        
        return Order(items: newItems)
    }
}

typealias Menu = [MenuItem]

struct MenuItem
{
    let name: String
    let type: String
    let price: Double
    
    var additions: [MenuAddition]
    var removals: [MenuAddition]
    
    init(name: String, type: String, price: Double) { // default struct initializer
        self.name = name
        self.type = type
        self.price = price
        
        self.additions = []
        self.removals = []
    }
    
}

extension MenuItem: Equatable {
    static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
//        if lhs.additions.count != rhs.additions.count{
//            return false
//        }
//        else{
//
//        }
        
        let additions = lhs.additions.map{ (a: MenuAddition) -> Bool in
            let temp =  rhs.additions.map{ (b: MenuAddition) -> Bool in
                return a==b
            }
            if temp.contains(true){
                return true
            }
            return false
        }
        print(additions)
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.type == rhs.type && !additions.contains(false)
    }
}

struct MenuAddition {
    let name: String
    let price: Double
}

extension MenuAddition: Equatable {

    static func ==(lhs: MenuAddition, rhs: MenuAddition) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}

extension LineItem: Equatable {
    static func ==(lhs: LineItem, rhs: LineItem) -> Bool {
        return lhs.item == rhs.item && lhs.quantity == rhs.quantity
    }
}

extension LineItem: Codable {
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
    
    //encode to json object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(item, forKey: .item)
    }
}

extension Order: Codable {
    enum Keys: String, CodingKey {
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let items: [LineItem] = try container.decode([LineItem].self, forKey: .items)
        
        self.init(items: items)
    }
    
    //encode to json object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(items, forKey: .items)
    }
}

extension MenuItem: Codable {
    enum Keys: String, CodingKey { // declaring our keys if different from API
        case name = "name"
        case type = "type"
        case price = "price"
    }

    //if unable to handle automatic decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self) // defining our (keyed) container
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        let type: String = try container.decode(String.self, forKey: .type)
        let price: Double = try container.decode(Double.self, forKey: .price)

        self.init(name: name, type: type, price: price) // initializing our struct
    }
    
    //encode to json object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(price, forKey: .price)
    }
}

