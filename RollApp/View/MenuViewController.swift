//
//  menuViewController.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.

import Foundation
import UIKit
import SnapKit

class MenuViewController: StatefulViewController<RollAppState>
{
    private let viewModel: MenuViewModel
    
    init(state: State, viewModel: MenuViewModel) {
        self.viewModel = viewModel
        
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = viewModel.title
        
        let titleView = UILabel()
        titleView.text = "Menu"
    }
}
