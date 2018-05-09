//
//  UIImageView+Extension.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/7/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func downloadImageFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, newHeight: CGFloat? = nil) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            // Resize the image
            if newHeight != nil {
                let scale = newHeight! / image.size.height
                let newWidth = image.size.width * scale
                UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight!))
                image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight!))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                DispatchQueue.main.async() {
                    self.image = newImage
                }
            } else {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
    
    func downloadImageFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, newHeight: CGFloat? = nil) {
        guard let url = URL(string: link) else { return }
        downloadImageFrom(url: url, contentMode: mode, newHeight: newHeight)
    }
    
}

