//
//  RollModel.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation

struct LineItem {
    var quantity: Int
    let item: MenuItem
}

struct Order
{
    var items: [LineItem]
}

var c = -1
extension Order {
    private func lineItemForMenuItem(_ item: MenuItem) -> Int? {
        c = 0;
        for i in items{
            if i.item == item{
                return c
            }
            c = c+1
        }
        c = -1
        return c
    }
    
    func orderByAddingItem(_ item: MenuItem) -> Order {
        var newItems = items
        let temp = lineItemForMenuItem(item)
        if temp != -1 {
            newItems.append(LineItem(quantity: items[c].quantity + 1, item: item))
            newItems.remove(at: temp!)
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
    
    init(name: String, type: String, price: Double, additions: [MenuAddition], removals:[MenuAddition]) { // default struct initializer
        self.name = name
        self.type = type
        self.price = price
        
        self.additions = additions
        self.removals = removals
    }
    
}

extension MenuItem: Equatable {
    static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
        
        let additions = lhs.additions.map{ (a: MenuAddition) -> Bool in
            let temp =  rhs.additions.map{ (b: MenuAddition) -> Bool in
                return a==b
            }
            if temp.contains(true){
                return true
            }
            return false
        }
        
        let removals = lhs.removals.map{ (a: MenuAddition) -> Bool in
            let temp =  rhs.removals.map{ (b: MenuAddition) -> Bool in
                return a==b
            }
            if temp.contains(true){
                return true
            }
            return false
        }
        
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.type == rhs.type && !additions.contains(false)
            && !removals.contains(false);
    }
}

struct MenuAddition: Hashable {
    let name: String
    let price: Double
//    let optional: Bool
//    let quantity: Int
    
    var hashValue: Int {
        return self.name.hashValue ^ self.price.hashValue
    }
    
    init(name: String, price: Double){
        self.name = name
        self.price = price
//        self.optional = optional
//        self.quantity = quantity
    }
    
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
    //keys if different from API
    enum Keys: String, CodingKey {
        case name = "name"
        case type = "type"
        case price = "price"
        case additions = "additions"
        case removals = "removals"
    }

    //if unable to handle automatic decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self) // defining our (keyed) container
        let name: String = try container.decode(String.self, forKey: .name) // extracting the data
        let type: String = try container.decode(String.self, forKey: .type)
        let price: Double = try container.decode(Double.self, forKey: .price)
        let additions: [MenuAddition] = (try container.decodeIfPresent([MenuAddition].self, forKey: .additions)) ?? []
        let removals: [MenuAddition] = (try container.decodeIfPresent([MenuAddition].self, forKey: .removals)) ?? []

        // initializing our struct
        self.init(name: name, type: type, price: price, additions: additions, removals: removals)
    }
    
    //encode to json object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(price, forKey: .price)
        try container.encode(additions, forKey: .additions)
        try container.encode(removals, forKey: .removals)
    }
}

//TESTED
extension MenuAddition: Codable{
    enum Keys: String, CodingKey {
        case name = "name"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        let price: Double = try container.decode(Double.self, forKey: .price)
        
        self.init(name: name, price: price)
    }
    
    //encode to json object
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
    }
}

//struct Ingredient {
//    let name: String
//    let extra: Bool
//    let price: Double
//
//    init(name: String, extra: Bool, price: Double) {
//        self.name = name
//        self.extra = extra
//        self.price = price
//    }
//}

