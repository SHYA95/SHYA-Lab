//
//  ImageLoader.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
   private let cache = NSCache<NSString, UIImage>()
    
    private init() {
       cache.countLimit = 100
    }
    
    func loadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        let cacheKey = urlString as NSString
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
       
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
