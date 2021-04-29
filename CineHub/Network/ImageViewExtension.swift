//
//  ImageViewExtension.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServer(urlString: String, placeholder: UIImage? = nil) {
        self.image = nil
        let imageURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error loading images")
                    DispatchQueue.main.async {
                        self.image = placeholder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageURL))
                            self.image = downloadedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
