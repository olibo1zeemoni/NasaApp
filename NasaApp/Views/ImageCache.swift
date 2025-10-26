//
//  ImageCache.swift
//  NasaApp
//
//  Created by Olibo moni on 26/10/2025.
//

import UIKit



final class ImageCache {
    
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    private init() {}
    
    /// Accesses the image for the given URL.
    ///
    /// Use this subscript to get or set images in the cache.
    /// `cache[url] = image`
    /// `let image = cache[url]`
    subscript(url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: url as NSURL)
            } else {
                cache.removeObject(forKey: url as NSURL)
            }
        }
    }
}
