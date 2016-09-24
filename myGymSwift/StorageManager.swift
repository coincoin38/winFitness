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
    
    func loadImageAsync(_ stringURL: String, completion: @escaping (UIImage?, NSError?) -> ())
    {
        let url     = URL(string: stringURL)
        let request = URLRequest(url: url!)
        let config  = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if error != nil {
                completion(nil, error as NSError!)
            } else {
                completion(UIImage(data: data!), nil)
            }
        });
        
        task.resume()
    }
}
