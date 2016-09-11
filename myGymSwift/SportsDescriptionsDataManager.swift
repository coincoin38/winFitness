//
//  SportsDescriptionsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import SwiftyJSON

class SportsDescriptionsDataManager: NSObject {
    
    func getSportsDescriptions(completion: (isOk:Bool) -> Void){
        
        self.getSportsDescriptionsfromDB({ (isOk) -> Void in
            completion(isOk: isOk)
        })
    }
    
    func feedDBWithDownloadedSportsDescriptions(sports: JSON,completion: (isOk:Bool) -> Void){
        
        RealmManager.SharedInstance.writeDataFromWS(3, json: sports, completion: { (isOk) -> Void in
            
            if isOk{
                self.getSportsDescriptionsfromDB({ (isOk) -> Void in
                    completion(isOk: isOk)
                })
            }
        })
    }
    
    func getSportsDescriptionsfromDB(completion: (isOk:Bool) -> Void){
        
        let arrayOfDescriptions = RealmManager.SharedInstance.getAllSportsDescriptions()
        
        if arrayOfDescriptions.count>0{
            completion(isOk: true)
        }
        completion(isOk: false)
    }
}