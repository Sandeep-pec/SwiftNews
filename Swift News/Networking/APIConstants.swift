//
//  APIConstants.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import Foundation

class APIConstants {
    static let redditURL: String = "https://www.reddit.com/r/swift/.json"
    
    enum StatusCodes: Int {
        case invalidURL = -400
        case errorResponse = -401
        case errorJson = -402
    }
}
