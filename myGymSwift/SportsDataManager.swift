//
//  SportsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import SwiftyJSON

class SportsDataManager: NSObject {
    
    func getSports(_ completion: @escaping (_ sportsArray: Array<SportModel>) -> Void){
        
        self.getSportsfromDB({ (sportsFromDB) -> Void in
            completion(sportsFromDB)
        })
    }
    
    func getSportsfromDB(_ completion: @escaping (_ sportsArray: Array<SportModel>) -> Void){
        
        RealmManager.SharedInstance.getAllSportsFromDB { (sports) -> Void in
            completion(sports)

        }
    }
    
    func getObjectivesFromDB(_ sport:SportModel, completion: @escaping (_ objectives: Array<ObjectiveModel>) -> Void){
        
        RealmManager.SharedInstance.getObjectivesWithSportId(sport.id, completion: { (objectives) -> Void in
            
            var objectivesArray: Array<ObjectiveModel> = Array<ObjectiveModel>()
            
            for objective in objectives{
                
                objectivesArray.append(objective)
                
            }
            completion(objectivesArray)
        })
    }
   
}
