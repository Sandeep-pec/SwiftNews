//
//  APIController.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import Foundation

class APIController {
    
    static let shared = APIController()
    
    func getNews(parameters: Any?, success: @escaping (Any?)->(), failure: @escaping (_ statusCode: Int?)->()) {
        
        //here will be internet checks
        
        HTTPClient.shared.requestGet(urlString: APIConstants.redditURL, parameters: parameters, success: { (json, statusCode)  in
            if let json = json as? [String: Any] {
                let newsResult: NewsDataResult = NewsDataResult.init(with: json)
                success(newsResult)
            } else {
                failure(APIConstants.StatusCodes.errorJson.rawValue)
            }
        }, failure: {(statusCode) in
            failure(statusCode)
        })
    }
}
