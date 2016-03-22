//
//  NewsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 14/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import SwiftyJSON

class NewsDataManager: NSObject {
    
    func getNewsOrdered(completion: (newsArray: Array<NewsModel>) -> Void){
        
        // Récupération du token
        AlamofireManager.SharedInstance.getToken { (isTokenOK) -> Void in
            
            if isTokenOK{
                
                AlamofireManager.SharedInstance.downloadOrderedNews({ (news) -> Void in
                    
                    self.feedDBWithDownloadedNews(news, completion: { (newsFromDB) -> Void in
                        completion(newsArray: newsFromDB)
                    })
                })
            }
            else{
                
                self.getNewsfromDB({ (newsFromDB) -> Void in
                    completion(newsArray: newsFromDB)
                })
            }
        }
    }
    
    func feedDBWithDownloadedNews(news: JSON,completion: (newsArray: Array<NewsModel>) -> Void){
        
        RealmManager.SharedInstance.writeDataFromWS(5, json: news, completion: { (isOk) -> Void in
            
            if isOk{
                self.getNewsfromDB({ (newsFromDB) -> Void in
                    completion(newsArray: newsFromDB)
                })
            }
        })
    }
    
    func getNewsfromDB(completion: (newsArray: Array<NewsModel>) -> Void){
        
        RealmManager.SharedInstance.getAllNewsFromDB { (news) -> Void in
            completion(newsArray:news)
        }
    }
}