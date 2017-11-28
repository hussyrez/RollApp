//
//  AppState.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/27/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit

protocol AppState
{
    //??WHAT
    func viewController() -> UIViewController
    
    static func transitionViewToState<T: UIViewController>(_ controller: T, state: Self) where T: StatefulView, T.State == Self
}
