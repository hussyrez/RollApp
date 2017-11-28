//
//  StatefulView.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/27/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit

protocol StatefulView
{
    associatedtype State
    
    var state: State {
        get
    }
}

class StatefulViewController<T>: UIViewController, StatefulView
{
    typealias State = T
    
    private let _state: T
    
    var state: T {
        get {
            return _state
        }
    }
    
    init(state: T)
    {
        _state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class StatefulTabController<T : AppState>: UITabBarController, StatefulView
{
    typealias State = T
    
    /*
     This dummy variable is here because the app crashes on iPhone 4S and 5
     
     My wild guess is that the Swift compiler incorrectly generates the memory
     layout for this class and UIKit attempts to send the message `layoutGuides`
     to the `_states` variable, assuming it to be the `view` member. Results in
     an exception.
     
     Maybe the cause is that a Swift subclass of an Obj-C class with an
     initial generic member incorrectly generates the storage for this
     class on certain CPU architectures?
     */
    private var dummyData = "This var prevents a crash on iPhone 5 and earlier"
    
    private let _state: T
    private var _states: [T] = []
    
    var stateToView: (T) -> UIViewController = { $0.viewController() }
    
    var state: T {
        get {
            return _state
        }
    }
    
    var selectedState: T {
        get {
            return states[selectedIndex]
        }
    }
    
    var states: [T] {
        set {
            _states = newValue
            
            viewControllers = _states.map { self.stateToView($0) }
        }
        
        get {
            return _states
        }
    }
    
    func setSelectedState(_ matchesState: (T) -> Bool)
    {
        if let index = states.index(where: matchesState)
        {
            selectedIndex = index
        }
    }
    
    init(state: T)
    {
        _state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
