//
//  bagViewController.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BagViewController: StatefulViewController<RollAppState>
{
    private let viewModel: BagViewModel
    
    init(state: State, viewModel: BagViewModel) {
        self.viewModel = viewModel
        
        super.init(state: state)
        
        title = viewModel.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
                
        let titleView = UILabel()
        titleView.text = "Bag"
    }
}
