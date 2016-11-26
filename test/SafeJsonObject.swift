//
//  SafeJsonObject.swift
//  test
//
//  Created by Jay on 24/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        //construct setNumber_of_likes selecotor
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}
