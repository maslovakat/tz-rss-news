//
//  NewsManager.swift
//  tz-rss-news
//
//  Created by Mac on 14.08.2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireRSSParser

protocol NewsSubscriber: CustomStringConvertible {
    func accept(changed newsItems: [NewsItem])
}

class NewsManager {
    
    static let shared = NewsManager()
    
    var newsItems: [NewsItem] = []
    private lazy var subscribers = [NewsSubscriber]()
    
    func add(subscriber: NewsSubscriber) {
        subscribers.append(subscriber)
    }
    
    func remove(subscriber filter: (NewsSubscriber) -> (Bool)) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach({ $0.accept(changed: newsItems) })
    }
    
    func getNewsByLink(url: String) {
        newsItems.removeAll()
        
        AF.request(url).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.value {
                for item in feed.items {

                   let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "dd MMM yyyy, HH:mm:ss"
                    let date = dateFormater.string(from: item.pubDate!)
                    
                    let post = NewsItem(title: item.title!, pubDate: date, description: item.itemDescription!, image: item.mediaContent ?? "")
                    self.newsItems.append(post)
                }
            }
            
            self.notifySubscribers()
        }
    }
}

