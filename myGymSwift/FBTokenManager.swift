//
//  FBManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FBTokenManager {

    static let SharedInstance = FBTokenManager()
    var access_token : String = String()

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
}
