//
//  RollAppState.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/27/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import MessageUI

indirect enum RollAppState: AppState {
    typealias State = RollAppState
    
    //Rolls States
    case menuAndBag
    case navigatable(state: State)
    case menu
    case bag(order: Order)
    case checkout
    case receipt
    
    func viewController() -> UIViewController {
        switch self{
        case .menuAndBag:
            let controller = StatefulTabController<RollAppState>(state: self);
            controller.states = [.navigatable(state: .menu),
                                 .navigatable(state: .bag(order: Order(items: [])))]; //empty order 4 now
            return controller
            
        case .navigatable(let state):
            let navigation = UINavigationController(rootViewController: state.viewController())
            return navigation
            
        case .menu:
            //linked
            let menuController = MenuViewController(state: self, viewModel: MenuViewModel())
            return menuController
            
        case .bag(let order):
            let bagController = BagViewController(state: self, viewModel: BagViewModel(order: order))
            return bagController
            
        case .checkout:
            return UIViewController()
            
        case .receipt:
            return UIViewController()
        }
    }
    
    static func transitionViewToState<T>(_ controllers: T, state: RollAppState) where RollAppState == T.State, T : UIViewController, T : StatefulView {
        
        let nextView = state.viewController()
        
        controllers.navigationController?.pushViewController(nextView, animated: true)
    }
    
    //State -> type alias declared above
    static func initialApplicationState() -> State {
        return .menuAndBag
    }
}
