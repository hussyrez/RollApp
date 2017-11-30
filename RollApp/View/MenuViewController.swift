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

class MenuViewController: StatefulViewController<RollAppState>, UITableViewDataSource
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
        
        title = viewModel.title
        
        let menuTable = UITableView()
        view.addSubview(menuTable)
        menuTable.snp.makeConstraints {
            make in

            make.edges.equalTo(view)
        }

        menuTable.dataSource = self
        menuTable.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        
//        let redView = UIView()
//        redView.backgroundColor = .red
//        view.addSubview(redView)
//        redView.snp.makeConstraints {
//            make in
//
//            make.center.equalTo(view.snp.center)
//            make.width.height.equalTo(100)
//        }
//        redView.layer.cornerRadius = 10.0

        
//        viewModel.didLoadMenu = {
//            menuTable.reloadData()
//        }
        setupRemoteConfigDefaults()
        updateValues()
        fetchRemoteConfig()
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
    
    func setupRemoteConfigDefaults(){
        let defaultValue =
        [
            "update" :
                """
                [
                    {
                    "name": "Mashed Potato Roll",
                    "price":  36
                    },
                    {
                    "name" : "Beef Roll",
                    "price" : 47
                    }
                ]
                """ as NSObject
        ]

//        let data = defaultValue[0]["update"].data(using: .utf8)!
//        do{
//            let myStruct = try JSONDecoder().decode([jsonItems].self, from: data) // Decoding our data
//        }catch{
//
//        }
        RemoteConfig.remoteConfig().setDefaults(defaultValue)
    }
    func fetchRemoteConfig(){
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings!
        //NOTE: throttle in deployment by keeping it 0!! change it later
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0){ [unowned self] (status, error) in
            guard error == nil else{
                print("FAILED connection!")
                return
            }
            print("SUCCESSFULL connection!")
            RemoteConfig.remoteConfig().activateFetched()
            self.updateValues()
        }

    }
    
    func updateValues(){
    }

    
}

