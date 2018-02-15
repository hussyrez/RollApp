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

protocol CustomizeDelegate {
    func didUpdateCustomize(item: MenuItem)
}

class CustomizeViewController: UIViewController {
    public var delegate: CustomizeDelegate?
    private var menuItem: MenuItem
    private var ingredients: Array<IngredientView> = []
    let stackView = UIStackView()
    let itemName: UILabel = {
        let label = UILabel()
        return label
    }()

    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
        
        setAndDisplay()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.spacing = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAndDisplay() {
        itemName.text = menuItem.name

        for (index, element) in menuItem.additions.enumerated() {
            let temp = IngredientView(menuAddition: element)
            temp.checkboxValueChanged = {
                [weak self] isOn in
                
                //if already on dont do anything otherwse add to additions
                if isOn {
                    self?.menuItem.additions.append(element)
                } else {
                    self?.menuItem.removals.append(element)
                }
               
                
            }
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

        stackView.snp.makeConstraints {
            make in
            make.top.equalTo(itemName.snp.bottom)
            make.left.right.equalToSuperview().inset(12)
        }
        for i in ingredients {
            stackView.addArrangedSubview(i)
        }
        
    }
    
    //sends the menuitem of this customized view to MenuViewController for updated values
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        delegate?.didUpdateCustomize(item: menuItem)
    }
    
}


class IngredientView :  UIView {
    
    var checkboxValueChanged: (Bool)->() = { _ in }
    
    private var ingredient : MenuAddition?
    private var checkBoxStatus : Bool?
    private var checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let name : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let price : UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(menuAddition: MenuAddition) {
        super.init(frame: .zero)
        
        self.ingredient = menuAddition
        self.name.text = ingredient?.name
        self.price.text = String(format:"%0.2f", (ingredient?.price)!)
        
        
        checkBox.setOn(true, animated: true)
        checkBox.onFillColor = UIColor(rgb: 0x6cf762)
        checkBox.onTintColor = UIColor(rgb: 0x6cf762)
        checkBox.onCheckColor = UIColor.white
//        checkBox.onAnimationType = BEMAnimationType.fill

        addSubview(checkBox)
        addSubview(name)
        addSubview(price)
        
        checkBox.addTarget(self, action: #selector(checkboxPressed(_:)), for: .valueChanged)
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
        
        price.snp.makeConstraints{
            make in
            make.right.equalToSuperview().offset(12)
            make.centerY.right.equalToSuperview()
        }
    }
    
    @objc private func checkboxPressed(_ sender: BEMCheckBox) {
        checkboxValueChanged(sender.on)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
