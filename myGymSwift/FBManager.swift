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

    func FBToken(_ completion:@escaping (_ success:Bool)  -> Void) {
        
        let authenticationRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath : NetworkConstants.FB_auth_url,
                                                                          parameters: NetworkConstants.FB_auth_parameters)
        
        authenticationRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(false)
            }
            let data:[String:AnyObject] = result as! [String : AnyObject]

            
            self.access_token = data[NetworkConstants.FB_access_token_key] as! String
            completion(true)
        })
    }
    
    func FBFeed(_ completion:@escaping (_ success:Bool)  -> Void) {
        
        let newsRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath    : NetworkConstants.FB_news_feed,
                                                                 parameters  : NetworkConstants.FB_news_parameters,
                                                                 tokenString : access_token as String,
                                                                 version     : NetworkConstants.FB_service_version,
                                                                 httpMethod  : NetworkConstants.FB_get)
        
        newsRequest.start(completionHandler: { (connection, result, error) -> Void in

            if ((error) != nil)
            {
                print("Error: \(error)")
                completion(false)
            }
          
            print("Result: \(result)")

            self.FBFeedModelisation(result as AnyObject)
            completion(true)
        })
    }
    
    func FBFeedModelisation(_ result: AnyObject){
        
        let resultDictionary : NSDictionary! = result as! [String: AnyObject] as NSDictionary!
        let resultData = resultDictionary.object(forKey: ModelsConstants.kData)as! [[String:AnyObject]]
        var feedsArray : [FBFeedModel] = []
        
        for feed in resultData
        {
            feedsArray.append(FBFeedModel.init(resultModel: feed as NSDictionary))
        }
        
        FBFeed = feedsArray
    }
}
