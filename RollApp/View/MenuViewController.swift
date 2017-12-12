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
//    private let bagViewController: BagViewController
    
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
        menuTable.delegate = self
        menuTable.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
//            cell.item = viewModel
            cell.itemName.text = viewModel.nameForMenuItem(at: indexPath)
            cell.backgroundColor = UIColor.brown

            return cell
        }
        
        fatalError("Could not dequeue cell of correct type")
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewAppeared()
    }
    
    private func reloadCellAtRow(row: Int) {
        let indexPath = NSIndexPath(row: row, section: 0)

    }

}

class MenuCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: MenuItem {
        get {
            return self.item
        }
        set {
            self.item = newValue
        }
    }

    @objc func onPress(){
        numberOfItems.text = String(Int((numberOfItems.text)!)!+1)
    }
    
    let numberOfItems: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor.white.cgColor
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    func setupCell() {
        contentView.addSubview(numberOfItems)
        contentView.addSubview(addButton)
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        addButton.addTarget(self, action: #selector(onPress), for: .touchUpInside)

        itemImage.snp.makeConstraints {
            make in
            
            make.height.equalTo(50)
            make.width.equalTo(100)
            
            make.top.left.equalToSuperview().inset(12)
        }
        
        itemName.snp.makeConstraints {
            make in
            
            make.top.equalTo(itemImage.snp.bottom).offset(12)
            make.left.equalTo(itemImage)
            make.bottom.equalToSuperview().inset(12)
        }
        
        addButton.snp.makeConstraints {
            make in
            make.right.top.equalToSuperview().inset(12)
            make.width.height.equalTo(44)
        }
        
        numberOfItems.snp.makeConstraints{
            make in
            make.width.height.equalTo(addButton)
            make.right.equalTo(addButton.snp.left).offset(-12)
            make.top.equalTo(addButton)
        }
    }
    
}
