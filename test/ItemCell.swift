//
//  CollectionCell.swift
//  test
//
//  Created by Jay on 19/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class ItemCell:BaseCell{
    
    var video:Video? {
        didSet{
            titleView.text = video?.title
            
            setupImage()
            setupprofileImage()
            
            if let channelName = video?.channel?.name, let numOfViews = video?.number_of_views{
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                content.text = "\(channelName) • \(numberFormatter.string(from: numOfViews)!) views • 2 years ago"
            }
            
            //measure title text
            if let title = video?.title{
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    //print("LLL")
                    titleLabelConstraint?.constant = 44
                    
                }else{
                    //print("Sm")
                    titleLabelConstraint?.constant = 20
                }
            
            }
        }
    }
    
    
    func setupImage(){
        if let imageURL = video?.thumbnail_image_name {
            image.loadImageUsingUrlString(imageURL)
        }
    }
    
    func setupprofileImage(){
        if let profileURL = video?.channel?.profile_image_name{
            profile.loadImageUsingUrlString(profileURL)
        }
    }
    
    //////////////////////
    let image: customUIImageView = {
        let imageView = customUIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let profile:customUIImageView = {
        let view = customUIImageView()
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleView:UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
        let content:UITextView = {
        let text = UITextView()
        text.isSelectable = false
        text.isEditable = false
        text.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        text.textColor = UIColor.lightGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    var titleLabelConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(image)
        addSubview(separatorView)
        addSubview(profile)
        addSubview(titleView)
        addSubview(content)
        
        addConstraintforItem(format: "H:|-16-[v0]-16-|", views: image)
        addConstraintforItem(format: "H:|-16-[v0(44)]", views: profile)
        addConstraintforItem(format: "H:|[v0]|", views: separatorView)
        //vertical
        addConstraintforItem(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: image,profile,separatorView)
        
        //addConstraintforItem(format: "V:[v0]-16-[v1(1)]|", views: content,separatorView)
        
        //title constraint
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .left, relatedBy: .equal, toItem: profile, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .right, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: 0))
        titleLabelConstraint = NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelConstraint!)
        
        //content constraint
        addConstraint(NSLayoutConstraint(item: content, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: content, attribute: .left, relatedBy: .equal, toItem: profile, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: content, attribute: .right, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
    
    
    
}
