//
//  ImageLoader.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/17/22.
//

import UIKit

class ImageLoader {    
    var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        DispatchQueue.global().async {
            let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            
            let url:NSURL = NSURL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url as URL) {
                data, response, error in
                if (error != nil) {
                    print(error?.localizedDescription)
                    completionHandler(nil, urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data!)
                    self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                    return
                }
            }
            task.resume()
        }
        
    }
}
