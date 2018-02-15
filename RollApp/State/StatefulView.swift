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
    
    init(state: T)
    {
        _state = state
        
        super.init(nibName: nil, bundle: nil)
        self.tabBar.barTintColor = UIColor.orange
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let _state: T
    private var _states: [T] = []
    
    var stateToView: (T) -> UIViewController = { $0.viewController() }
    
    //get current _state
    var state: T {
        get {
            return _state
        }
    }
    
    //get state on given index
    var selectedState: T {
        get {
            return states[selectedIndex]
        }
    }
    
    //set _states to [T] where T -> AppState|RollAppState
    //also returns the array _states
    var states: [T] {
        set {
            _states = newValue
            
            //??what
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
    
}
