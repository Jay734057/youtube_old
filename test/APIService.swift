//
//  APIService.swift
//  test
//
//  Created by Jay on 22/11/2016.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class APIservice: NSObject {
    static let sharedInstance = APIservice()
    
    let URLprefix = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    let URLsuffix = ".json"
    
    
    func fetchVideos(completion:@escaping ([Video])->()){
        fetchFromURL(url: "\(URLprefix)home_num_likes\(URLsuffix)", completion: completion)
    }
    
    func fetchTrendingVideos(completion:@escaping ([Video])->()){
        fetchFromURL(url: "\(URLprefix)trending\(URLsuffix)", completion: completion)
    }
    
    func fetchSubscriptionVideos(completion:@escaping ([Video])->()){
        fetchFromURL(url: "\(URLprefix)subscriptions\(URLsuffix)", completion: completion)
    }
    
    func fetchFromURL(url:String, completion:@escaping ([Video])->()){
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do {
                if let unwrapped = data,
                    let json = try JSONSerialization.jsonObject(with: unwrapped, options: .mutableContainers) as? [[String: AnyObject]] {
                    let videos = json.map({return Video(dictionary: $0)})
                        DispatchQueue.main.async(execute: {
                            completion(videos)
                        })
                }
            } catch let error {
                print(error)
            }
        }).resume()
    }

}


//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//    video.channel = channel
//
//    videos.append(video)
//}
//
//dispatch_async(dispatch_get_main_queue(), {
//    completion(videos)
//})




//                    let numbersArray = [1, 2, 3]
//                    let doubledNumbersArray = numbersArray.map({return $0 * 2})
//                    let stringsArray = numbersArray.map({return "\($0 * 2)"})
//                    print(stringsArray)

//                    var videos = [Video]()
//
//                    for dictionary in jsonDictionaries {
//                        let video = Video(dictionary: dictionary)
//                        videos.append(video)
//                    }


