//
//  CacheManager.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-05.
//

import UIKit

class CacheManager: NSObject {
    static let shared = CacheManager()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    //save image to cache
    func getImage(urlString: String) -> UIImage? {
        let image = imageCache.object(forKey: NSString(string: urlString))
        return image
    }
    
    //retrieve image from cache
    func setImage(urlString: String, image: UIImage) {
        imageCache.setObject(image, forKey: urlString as NSString)
    }
}
