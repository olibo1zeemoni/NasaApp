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
