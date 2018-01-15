//
//  CustomizeViewController.swift
//  RollApp
//
//  Created by Azil Hasnain on 12/12/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CustomizeViewController: UIViewController {
    private var menuItem: MenuItem?
    
    private var incrementButton = [UIButton: UILabel]()
    private var ingredients = [MenuAddition : UILabel]()
    
    init(menuItem: MenuItem) {
        super.init(nibName: nil, bundle: nil)
        self.menuItem = menuItem
        
        setAndDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setAndDisplay() {
        itemName.text = menuItem?.name
        for i in (menuItem?.additions)! {
            let numberOfItems: UILabel = {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                label.layer.borderColor = UIColor.black.cgColor
                label.layer.borderWidth = 1
                label.layer.backgroundColor = UIColor.white.cgColor
                label.layer.cornerRadius = 5
                label.text = "0"
                label.textAlignment = .center
                return label
            }()
            
            ingredients[i] = numberOfItems
            
            let addButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle("+", for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(rgb: 0xed500e)
                button.layer.cornerRadius = 5
                return button
            }()
            
            incrementButton[addButton] = numberOfItems
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Customize Item"
        self.view.backgroundColor = UIColor(rgb:0x775d4a)
        self.view.addSubview(itemName)
        
        itemName.snp.makeConstraints {
            make in
            
            make.height.equalTo(50)
            make.width.equalTo(100)
            
            make.top.left.equalToSuperview().inset(12)
        }
//        for i in (menuItem?.additions)! {
//
//        }
        var myCheckBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        myCheckBox.onFillColor = UIColor(rgb: 0x6cf762)
        myCheckBox.onTintColor = UIColor(rgb: 0x6cf762)
        myCheckBox.onCheckColor = UIColor.white
        view.addSubview(myCheckBox as? UIView ?? UIView())
        myCheckBox.snp.makeConstraints {
            make in
            make.top.right.equalToSuperview().inset(12)
        }
    }
    
}


class CustomItems :  UIViewController {
    private var ingredient : MenuAddition?
    private var checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let name : UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(menuAddition: MenuAddition) {
        super.init(nibName: nil, bundle: nil)
        self.ingredient = menuAddition
        self.name.text = ingredient?.name
        checkBox.onFillColor = UIColor.green
        checkBox.onCheckColor = UIColor.white
        checkBox.onAnimationType = BEMAnimationType.bounce
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

    }
}
