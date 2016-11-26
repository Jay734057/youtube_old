//
//  Helper.swift
//  test
//
//  Created by Jay on 19/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

extension UIView{
    //add constraint programmingly
    func addConstraintforItem(format: String, views: UIView...){
        var viewDictionary = [String: UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
    
    
}

extension UIColor{
    //set up color by rgb values
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

}

let imageCache = NSCache<NSString, UIImage>()

class customUIImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString( _ urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
            
        }).resume()
    }

}


