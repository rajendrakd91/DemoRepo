//
//  imageCacher.swift
//  CgExercise
//
//  Created by Test User 1 on 11/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

typealias ImageCacheLoaderCompletionHandler = ((UIImage?) -> ())

class ImageCacheLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String?, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
//        let placeholder = #imageLiteral(resourceName: "sample")
        if imagePath == nil{
            DispatchQueue.main.async {
                completionHandler(nil)
                return
            }
        }
        else{
            if let image = self.cache.object(forKey: imagePath! as NSString) {
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            } else {
                /* You need placeholder image in your assets,
                 if you want to display a placeholder to user */
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
                let url: URL! = URL(string: imagePath!)
                if url == nil { return }
                task = session.downloadTask(with: url, completionHandler: {[unowned self] (location, response, error) in
                    if let data = try? Data(contentsOf: url) {
                        let img: UIImage! = UIImage(data: data)
                        if img != nil {
                            self.cache.setObject(img, forKey: imagePath as! NSString)
                            DispatchQueue.main.async {
                                completionHandler(img)
                            }
                        }
                    }
                    })
                task.resume()
            }
        }
    }
}
