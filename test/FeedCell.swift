//
//  FeedCell.swift
//  test
//
//  Created by Jay on 23/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class FeedCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    let url:String? = nil
    
    let cellId = "cellId"
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]?
    
    var homeController:HomeCollection?
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        backgroundColor = UIColor.black
        
        addSubview(collection)
        addConstraintforItem(format: "H:|[v0]|", views: collection)
        addConstraintforItem(format: "V:|[v0]|", views: collection)
        
        collection.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //set up cell content
    func fetchVideos(){
        APIservice.sharedInstance.fetchVideos{ (videos: [Video]) in
            self.videos = videos
            self.collection.reloadData()
        }
    }
    
    //collection cell set up
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videos?.count ?? 0
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ItemCell
            cell.video = videos?[indexPath.item]
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 16 - 16) * 9 / 16
            return CGSize(width: frame.width, height: height + 16 + 88 + 1)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let videoLauncher = VideoLauncher()
            videoLauncher.showVideoView()

    }
    
    private var lastContentOffset: CGFloat = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset - collection.contentOffset.y > 100) {
            // move up
            //print("up")
            homeController?.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else if (self.lastContentOffset < collection.contentOffset.y - 100) {
            // move down
            //print("down")
            homeController?.navigationController?.setNavigationBarHidden(true, animated: true)
            
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
