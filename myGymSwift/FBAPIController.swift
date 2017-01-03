//
//  FBAPIController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 07/10/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Foundation
import FBSDKCoreKit

protocol FBAPIControllerProtocol {
    func didReceiveAPIResults(results: Array<FBFeedModel>)
}

class FBAPIController {
    
    var delegate: FBAPIControllerProtocol?
    
    func FBFeed() {
        
        let newsRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath   : NetworkConstants.FB_news_feed,
                                                                parameters  : NetworkConstants.FB_news_parameters,
                                                                tokenString : FBTokenManager.SharedInstance.access_token as String,
                                                                version     : NetworkConstants.FB_service_version,
                                                                httpMethod  : NetworkConstants.FB_get)
        
        newsRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(error)")
            }
            
            //print("Result: \(result)")
            
            self.FBFeedModelisation(result as AnyObject)
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
        
        self.delegate?.didReceiveAPIResults(results: feedsArray)
    }
}
