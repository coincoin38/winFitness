//
//  AlamofireManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 13/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AlamofireManager: NSObject {
    
    static let SharedInstance = AlamofireManager()
    
    var token = ""
    
    let login_params            = NetworkConstants.login_parameters
    let post_token              = NetworkConstants.ip_server+NetworkConstants.post_token
    let get_news                = NetworkConstants.ip_server+NetworkConstants.get_news
    let get_ordered_news        = NetworkConstants.order_news
    let get_sports              = NetworkConstants.ip_server+NetworkConstants.get_sports
    let get_sports_descriptions = NetworkConstants.ip_server+NetworkConstants.get_sports_descritptions
    
    // MARK: - Certificat SSL porvisoire

    func setChallenge(){
    
        Alamofire.Manager.sharedInstance.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    credential = Alamofire.Manager.sharedInstance.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
    
    // MARK: - Token/Post
    
    func getToken(completion: (Bool) -> Void) {
        if (self.token != ""){
            completion(true)
        }
        else{
            print("Authentification : \(post_token)...")
            Alamofire.request(.POST, post_token, parameters: login_params, encoding: .JSON) .responseJSON{
                response in
                
                switch response.result {
                    
                case .Success:
                    if response.response!.statusCode == 200 {
                        let credential = JSON(response.result.value!)
                        print("Token ok")
                        //print("...Token ok: \(credential)")
                        self.token = credential["id"].stringValue
                        completion(true)
                        
                    } else {
                        print("Request failed with error: \(response.response!.statusCode)")
                        completion(false)
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    completion(false)
                }
            }
        }
    }
    
    // MARK: - Download/Get
    
    func genericDownload(url:String,completion: (data: JSON) -> Void){
        
        Alamofire.request(.GET,url).responseJSON{
            response in
            
            switch response.result {
                
            case .Success:
                if response.response!.statusCode == 200 {
                    print("Download ok")
                    //print("...Content : \(response.result.value)")
                    completion(data:JSON(response.result.value!))
                } else {
                    print("Request failed with error: \(response.response!.statusCode)")
                    completion(data:[])
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(data:[])
            }
        }
    }
    
    func downloadOrderedNews(completion: (news: JSON) -> Void) {
        genericDownload(get_news+token+get_ordered_news) { (data) -> Void in
            completion(news: data)
        }
    }
    
    func downloadSports(completion: (sports: JSON) -> Void) {
        genericDownload(get_sports+token) { (data) -> Void in
            completion(sports: data)
        }
    }
    
    func downloadSportsDescriptions(completion: (sportsDescriptions: JSON) -> Void) {
        
        genericDownload( get_sports_descriptions+token) { (data) -> Void in
            completion(sportsDescriptions: data)
        }
    }
}