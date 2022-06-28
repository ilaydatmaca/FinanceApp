import UIKit

class ImageLoader {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedInstance : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
        
        // Check for a cached image.
        if let imageData = data {
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async {
                completionHandler(image, urlString)
            }
            return
        }
        
        // Go fetch the image.
        // Cache the image.

        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            
            //check there is not an error and data is not null
            if error == nil {
                if data != nil {
                    let image = UIImage.init(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)//load the cache
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                }
            } else { //else return empty
                completionHandler(nil, urlString)
            }
        }
        downloadTask.resume()
    }
}
