//
//  VideoLauncher.swift
//  test
//
//  Created by Jay on 25/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class VideoLauncher:NSObject{
    let view = UIView()
    func showVideoView(){
        if let keyWindow = UIApplication.shared.keyWindow{
            //let view = UIView()
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: keyWindow.frame.width - 1, y: keyWindow.frame.height - 1, width: 1, height: 1)
            //view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(hideVideoView)))
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width*9/16))
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height)
            }, completion: { (completionAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}


