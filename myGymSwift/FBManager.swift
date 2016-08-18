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
    var FBFeed       : Array<FBFeedModel>! = Array<FBFeedModel>()

    func FBToken(completion:(success:Bool)  -> Void) {
        
        let authenticationRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath : NetworkConstants.FB_auth_url,
                                                                          parameters: NetworkConstants.FB_auth_parameters)
        
        authenticationRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(success: false)
            }
            
            self.access_token = result.valueForKey(NetworkConstants.FB_access_token_key) as! String
            completion(success: true)
        })
    }
    
    func FBFeed(completion:(success:Bool)  -> Void) {
        
        let newsRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath    : NetworkConstants.FB_news_feed,
                                                                 parameters  : NetworkConstants.FB_news_parameters,
                                                                 tokenString : access_token as String,
                                                                 version     : NetworkConstants.FB_service_version,
                                                                 HTTPMethod  : NetworkConstants.FB_get)
        
        newsRequest.startWithCompletionHandler({ (connection, result, error) -> Void in

            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(success : false)
            }
          
            print("Result: \(result)")

            self.FBFeedModelisation(result)
            completion(success : true)
        })
    }
    
    func FBFeedModelisation(result: AnyObject){
        
        let resultDictionary : NSDictionary! = result as! [String: AnyObject]
        let resultData = resultDictionary.objectForKey(ModelsConstants.kData)as! [[String:AnyObject]]
        var feedsArray : [FBFeedModel] = []
        
        for feed in resultData
        {
            feedsArray.append(FBFeedModel.init(resultModel: feed))
        }
        
        FBFeed = feedsArray
    }
}
