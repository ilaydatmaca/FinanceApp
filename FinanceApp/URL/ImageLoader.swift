
import UIKit

class URLLoader {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedInstance : URLLoader {
        struct Static {
            static let instance : URLLoader = URLLoader()
        }
        return Static.instance
    }
    
    func anyForUrl<T : Decodable>(typeStr : String?, urlString: String,  typeClass : T.Type? = nil, completionHandler:@escaping (_ image: UIImage?, _ url: String ,_ typereturn : T?) -> ()) {
        
        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData
        
        // Check for a cached image.
        if let data = data {
            if typeStr == "image"{
                let image = UIImage(data: data as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString, nil)
                }
                return
            }
            else if typeStr == "text"{
                let coinResult = try? JSONDecoder().decode(T.self, from: data as Data)
                DispatchQueue.main.async {
                    completionHandler(nil, urlString, coinResult)
                }
                return
            }
            
        }
        
        // Go fetch the image.
        // Cache the image.
        
        
        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            if(data == nil){
                return
            }
            
            //check there is not an error and data is not null
            if error == nil {
                if data != nil {
                    
                    if typeStr == "image"{
                        
                        let image = UIImage.init(data: data!)
                        self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)//load the cache
                        DispatchQueue.main.async {
                            completionHandler(image, urlString, nil)
                        }
                    }
                    else if typeStr == "text"{
                        
                        let coinResult = try? JSONDecoder().decode(T.self, from: data! as Data)
                        self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)//load the cache
                        DispatchQueue.main.async {
                            completionHandler(nil, urlString, coinResult)
                        }
                    }
                }
            } else { //else return empty
                completionHandler(nil, urlString, nil)
            }
        }
        downloadTask.resume()
    }
}
