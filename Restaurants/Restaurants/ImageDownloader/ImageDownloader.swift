//
//  ImageDownloader.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-24.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

typealias ImageDownloadCompletion = (Result<UIImage, Error>) -> Void

var imageCache = NSCache<AnyObject, AnyObject>()

enum ImageDownloadError: Error {
    case invalidImageUrl
    case invalidImage
}

class ImageDownloader {
    
    class func download(urlString: String, completion: ImageDownloadCompletion?) {
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion?(.success(cacheImage))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion?(.failure(ImageDownloadError.invalidImageUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                completion?(.success(image))
            }
        }.resume()
    }
}
