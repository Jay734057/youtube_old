//
//  Setting.swift
//  test
//
//  Created by Jay on 27/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class Setting: NSObject{
    let name: SettingName
    let imageName: String
    
    init(name:SettingName,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Setting = "Setting"
    case Privacy = "Terms & privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case Switch = "Switch Account"
    
}
