//
//  SettingCell.swift
//  test
//
//  Created by Jay on 22/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class SettingCell: BaseCell{
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        addConstraintforItem(format: "H:|-16-[v1(30)]-8-[v0]|", views: nameLabel,iconImageView)
        addConstraintforItem(format: "V:|[v0]|", views: nameLabel)
        addConstraintforItem(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
    let nameLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var setting:Setting?{
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let name = setting?.imageName{
                iconImageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray: UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
}
