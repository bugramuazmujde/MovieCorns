//
//  LoadImage.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation
import UIKit


class ImageLoader {
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func loadImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: NSString(string: urlString)) {
            completion(image)
        } else {
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: NSString(string: urlString))
                        completion(image)
                    }
                }
            }
            task.resume()
        }
    }
}
