//
//  SportsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import SwiftyJSON

class SportsDataManager: NSObject {
    
    func getSports(completion: (sportsArray: Array<SportModel>) -> Void){
        
        // Récupération du token
        AlamofireManager.SharedInstance.getToken { (isTokenOK) -> Void in
            
            if isTokenOK{
                
                AlamofireManager.SharedInstance.downloadSports({ (sports) -> Void in
                    
                    self.feedDBWithDownloadedSports(sports, completion: { (sportsFromDB) -> Void in
                        completion(sportsArray: sportsFromDB)
                    })
                })
            }
            else{
                
                self.getSportsfromDB({ (sportsFromDB) -> Void in
                    completion(sportsArray: sportsFromDB)
                })
            }
        }
    }
    
    func feedDBWithDownloadedSports(sports: JSON,completion: (newsArray: Array<SportModel>) -> Void){
        
        RealmManager.SharedInstance.writeDataFromWS(2, json: sports, completion: { (isOk) -> Void in
            
            if isOk{
                self.getSportsfromDB({ (newsFromDB) -> Void in
                    completion(newsArray: newsFromDB)
                })
            }
        })
    }
    
    func getSportsfromDB(completion: (sportsArray: Array<SportModel>) -> Void){
        
        RealmManager.SharedInstance.getAllSportsFromDB { (sports) -> Void in
            completion(sportsArray:sports)

        }
    }
    
    func getObjectivesFromDB(sport:SportModel, completion: (objectives: Array<ObjectiveModel>) -> Void){
        
        RealmManager.SharedInstance.getObjectivesWithSportId(sport.id, completion: { (objectives) -> Void in
            
            var objectivesArray: Array<ObjectiveModel> = Array<ObjectiveModel>()
            
            for objective in objectives{
                
                objectivesArray.append(objective)
                
            }
            completion(objectives: objectivesArray)
        })
    }
   
}