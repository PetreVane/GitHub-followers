//
//  CacheManager.swift
//  Github-Followers
//
//  Created by Petre Vane on 16/01/2020.
//  Copyright © 2020 Petre Vane. All rights reserved.
//

import UIKit

struct CacheManager {

    static let sharedInstance = CacheManager()
    static let cache = NSCache<NSString, UIImage>()
    
    
    /// Save images to cache
    /// - Parameters:
    ///   - key: used to save images to cache
    ///   - image: the image to be cached
    func saveImage(withIdentifier key: String, image: UIImage) {
        
        let cachingKey = NSString(string: key)
        CacheManager.cache.setObject(image, forKey: cachingKey)
    }
    
    
    
    /// Retrieves images from cache
    /// - Parameter key: used in saving the image to cache
    func retrieveImage(withIdentifier key: String) -> UIImage? {
        let cachingKey = NSString(string: key)
        guard let image = CacheManager.cache.object(forKey: cachingKey) else { return nil }
        return image
    }
}
