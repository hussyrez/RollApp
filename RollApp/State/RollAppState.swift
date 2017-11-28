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
    case menuAndBag(menuUrl: URL)
    case navigatable(state: State)
    case menu(menuUrl: URL)
    case bag
    case checkout
    case receipt
    
    func viewController() -> UIViewController {
        switch self{
        case .menuAndBag(let url):
            let controller = StatefulTabController<RollAppState>(state: self);
            controller.states = [.navigatable(state: .menu(menuUrl: url)), .navigatable(state: .bag)]
            return controller
        case .navigatable(let state):
            let navigation = UINavigationController(rootViewController: state.viewController())
            return navigation
        case .menu(let url):
            //linked
            let menuController = MenuViewController(state: self, viewModel: MenuViewModel(menuUrl: url))
            return menuController
        case .bag:
            let bagController = BagViewController()
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
        return .menuAndBag(menuUrl: URL(string: "https://google.com")!)
    }
}
