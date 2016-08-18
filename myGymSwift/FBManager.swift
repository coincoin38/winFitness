//
//  FBManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FBManager: NSObject {

    static let SharedInstance = FBManager()
    var access_token : String = String()
    
    func getFBToken(completion:(bool:Bool)  -> Void) {
        
        let authenticationRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath : NetworkConstants.FB_auth_url,
                                                                          parameters: NetworkConstants.FB_auth_parameters)
        
        authenticationRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(bool: false)
            }
            else
            {
                self.access_token = result.valueForKey(NetworkConstants.FB_access_token_key) as! String
                completion(bool: true)
            }
        })
    }
    
    func getFBNews(completion:(news:String!)  -> Void) {
        
        
        let newsRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath    : NetworkConstants.FB_news_feed,
                                                                 parameters  : NetworkConstants.FB_news_parameters,
                                                                 tokenString : access_token as String,
                                                                 version     : NetworkConstants.FB_service_version,
                                                                 HTTPMethod  : NetworkConstants.FB_get)
        
        newsRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            var resultDictionary:NSDictionary!

            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(news : nil)
            }
            else
            {
                //print("Result: \(result)")
                resultDictionary = result as! [String: AnyObject]
                let test = resultDictionary.objectForKey("data")as! [[String:AnyObject]]
                print("Test: \(test)")
                completion(news: "youpi")
            }

        })
    }
}
