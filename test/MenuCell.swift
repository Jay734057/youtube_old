//
//  MenuCell.swift
//  test
//
//  Created by Jay on 19/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class MenuCell: BaseCell{
    let icon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(icon)
        addConstraintforItem(format: "H:[v0(28)]", views: icon)
        addConstraintforItem(format: "V:[v0(28)]", views: icon)
        
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override var isHighlighted: Bool{
        didSet{
            icon.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            icon.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
}
