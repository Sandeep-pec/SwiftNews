//
//  NewsArticle.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-04.
//

import Foundation

class NewsArticle: NSObject {
    var kind: String?
    var title: String?
    var thumbnail: String?
    var selfText: String?
    var urlString: String?
    var thumbnail_height: Int = 0
    var thumbnail_width: Int = 0
    
    init(with dict: [String: Any?]?) {
        kind = dict?["kind"] as? String
        
        let data = dict?["data"] as? [String: Any?]
        title = data?["title"] as? String
        selfText = data?["selftext"] as? String
        thumbnail = data?["thumbnail"] as? String
        urlString = data?["url"] as? String
        thumbnail_height = data?["thumbnail_height"] as? Int ?? 0
        thumbnail_width = data?["thumbnail_width"] as? Int ?? 0
        
        if !((thumbnail ?? "").contains("http")) {
            thumbnail = nil
        }
    }
}
