//
//  TrendingCell.swift
//  test
//
//  Created by Jay on 24/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        APIservice.sharedInstance.fetchTrendingVideos{ (videos: [Video]) in
            self.videos = videos
            self.collection.reloadData()
        }
    }

}
