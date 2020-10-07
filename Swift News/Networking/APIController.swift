//
//  APIController.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import Foundation

class APIController {
    
    static let shared = APIController()
    //news api, parse json into models and do any local memory functions
    func getNews(parameters: Any?, success: @escaping (Any?)->(), failure: @escaping (_ statusCode: Int?)->()) {
        
        //here will be internet checks
        
        HTTPClient.shared.requestGetApi(urlString: APIConstants.redditURL, parameters: parameters, success: { (json, statusCode)  in
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
