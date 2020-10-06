//
//  HTTPClient.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import UIKit


class HTTPClient {
    
    static let shared = HTTPClient()
    
    func requestGet(urlString: String?, parameters: Any?, success: @escaping (_ data: Any?, _ statusCode: Int?)->(), failure: @escaping (_ statusCode: Int?)->()) {
        
        guard let urlString = urlString, let url = URL.init(string: urlString) else { failure(APIConstants.StatusCodes.invalidURL.rawValue)
            return }
        let configuration = URLSessionConfiguration .default
        let session = URLSession(configuration: configuration)

        print("get news url string is \(urlString)")
        var request : URLRequest = URLRequest(url:url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let _: Void = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                // OH NO! An error occurred...
                failure(APIConstants.StatusCodes.errorResponse.rawValue)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(APIConstants.StatusCodes.errorResponse.rawValue)
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                guard let mime = httpResponse.mimeType, mime == "application/json" else {
                        print("Wrong MIME type!")
                        failure(APIConstants.StatusCodes.errorResponse.rawValue)
                        return
                    }

                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        success(json, httpResponse.statusCode)
                        //print(json)
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                        failure(APIConstants.StatusCodes.errorJson.rawValue)
                    }
                
            } else {
                failure(httpResponse.statusCode)
                return
            }
            
        }.resume()
    }
    
}
