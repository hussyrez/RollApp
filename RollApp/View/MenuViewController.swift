//
//  menuViewController.swift
//  RollApp
//
//  Created by Azil Hasnain on 11/28/17.
//  Copyright © 2017 Enabled. All rights reserved.

import Foundation
import UIKit
import SnapKit
import Firebase

class MenuViewController: StatefulViewController<RollAppState>, UITableViewDataSource, UITableViewDelegate
{
    
    private let viewModel: MenuViewModel
    
    init(state: State, viewModel: MenuViewModel) {
        self.viewModel = viewModel
        
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n\n\n")
        print("CALLED CALLED CALLED")
        print("\n\n\n")
        
        title = viewModel.title
        
        let menuTable = UITableView()
        view.addSubview(menuTable)
        menuTable.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
        
        menuTable.dataSource = self
        menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        
        viewModel.didLoadMenu = {
            menuTable.reloadData()
        }
    }
    
    //MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedItemAtIndex(indexPath)
    }
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMenuItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.nameForMenuItem(at: indexPath)
        
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewAppeared()
    }
}

