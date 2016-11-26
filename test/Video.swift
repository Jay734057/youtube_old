//
//  Video.swift
//  test
//
//  Created by Jay on 19/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class Video: SafeJsonObject{
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration:NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel"{
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        }else{
            super.setValue(value, forKey: key)

        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}

