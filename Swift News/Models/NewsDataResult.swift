//
//  NewsDataResult.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-04.
//

import Foundation

class NewsDataResult: NSObject {
    var kind: String?
    var data: [String: Any?]?
    var list: [NewsArticle] = []
    
    init(with dictionary: [String:Any?]) {
        kind = dictionary["kind"] as? String
        data = dictionary["data"] as? [String: Any?]
        if let results = data?["children"] as? [[String: Any?]] {
            for item in results {
                list.append(NewsArticle.init(with: item))
            }
        }
    }
}
