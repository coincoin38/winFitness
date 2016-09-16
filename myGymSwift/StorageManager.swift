//
//  StorageManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 15/09/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class StorageManager: NSObject {

    static let SharedInstance = StorageManager()
    
    func loadImageAsync(stringURL: String, completion: (UIImage!, NSError!) -> ())
    {
        let url     = NSURL(string: stringURL)
        let request = NSURLRequest(URL: url!)
        let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                completion(nil, error)
            } else {
                completion(UIImage(data: data!), nil)
            }
        });
        
        task.resume()
    }
}