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
    private var ingredients: Array<IngredientView> = []
    let stackView = UIStackView()
    let itemName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(menuItem: MenuItem) {
        super.init(nibName: nil, bundle: nil)
        self.menuItem = menuItem
        
        setAndDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAndDisplay() {
        itemName.text = menuItem?.name

        for i in (menuItem?.additions)! {
            let temp = IngredientView(menuAddition: i)
            ingredients.append(temp)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Customize Item"
        view.backgroundColor = UIColor(rgb:0x775d4a)
        view.addSubview(itemName)
        view.addSubview(stackView)

        itemName.snp.makeConstraints {
            make in
            
            make.height.equalTo(50)
            make.width.equalTo(100)
            
            make.top.left.equalToSuperview().inset(12)
        }
        
        for i in ingredients {
            stackView.addArrangedSubview(i)
        }

        stackView.snp.makeConstraints {
            make in
            make.top.equalTo(itemName.snp.bottom)
            make.left.right.equalToSuperview().inset(12)
        }
        
    }
    
}


class IngredientView :  UIView {
    private var ingredient : MenuAddition?
    private var checkBoxStatus : Bool?
    private var checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let name : UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(menuAddition: MenuAddition) {
        super.init(frame: .zero)
        
        self.ingredient = menuAddition
        self.name.text = ingredient?.name
        checkBoxStatus = checkBox.on
        checkBox.onFillColor = UIColor(rgb: 0x6cf762)
        checkBox.onTintColor = UIColor(rgb: 0x6cf762)
        checkBox.onCheckColor = UIColor.white
        checkBox.onAnimationType = BEMAnimationType.fill

        addSubview((checkBox as UIView))
        addSubview(name)
        
        checkBox.snp.makeConstraints {
            make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(checkBox.snp.height)
        }
        
        name.snp.makeConstraints {
            make in
            make.left.equalTo(checkBox.snp.right).offset(12)
            make.centerY.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
