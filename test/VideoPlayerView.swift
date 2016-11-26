//
//  VideoPlayerView.swift
//  test
//
//  Created by Jay on 27/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView{
    //junhua
    let activityIndcatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let videoCurrentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.red
        slider.setThumbImage(UIImage(named:"thumb"), for: .normal)
        slider.maximumTrackTintColor = UIColor.white
        slider.isEnabled = false
        slider.addTarget(self, action: #selector(handleSliderchange), for: .valueChanged)
        return slider
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 1)
        return v
    }()
    
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupGradientLayer()
        
        containerView.frame = frame
        addSubview(containerView)
        
        containerView.addSubview(activityIndcatorView)
        activityIndcatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndcatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        containerView.addSubview(pauseButton)
        pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        containerView.addSubview(videoCurrentLabel)
        videoCurrentLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: -8).isActive = true
        videoCurrentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        videoCurrentLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoCurrentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        containerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -6).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: videoCurrentLabel.rightAnchor, constant: 6).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        backgroundColor = UIColor.black
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player: AVPlayer?
    
    
    private func setupPlayerView(){
        if let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"){
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            
            //track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main , using: {
                (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondText = String(format: "%02d", Int(seconds) % 60)
                let minuteText = String(format: "%02d", Int(seconds) / 60)
                self.videoCurrentLabel.text = "\(minuteText):\(secondText)"
                
                //set slider
                if let duration = self.player?.currentItem?.duration{
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
                
            })
        }
    }
    
    
    private func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.7, 1.2]
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        containerView.layer.addSublayer(gradientLayer)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndcatorView.stopAnimating()
            containerView.backgroundColor = .clear
            pauseButton.isHidden = false
            videoSlider.isEnabled = true
            isPlaying = true
            
            if let duration = player?.currentItem?.duration{
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
            
        }
    }
    
    func handlePause(){
        if isPlaying {
            player?.pause()
            pauseButton.setImage(UIImage(named:"play"), for: .normal)
        }else{
            player?.play()
            pauseButton.setImage(UIImage(named:"pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    var isPlaying = false
    
    func handleSliderchange(){
        if let duration = player?.currentItem?.duration{
            let total = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * total
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: {
                (completedSeek) in
            })
        }
        
        
    }
    
    
    
}
