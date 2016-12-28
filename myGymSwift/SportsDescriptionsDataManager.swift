//
//  SportsDescriptionsDataManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import SwiftyJSON

class SportsDescriptionsDataManager: NSObject {
    
    func getSportsDescriptions(_ completion: @escaping (_ isOk:Bool) -> Void){
        
        self.getSportsDescriptionsfromDB({ (isOk) -> Void in
            completion(isOk)
        })
    }
    
    func getSportsDescriptionsfromDB(_ completion: (_ isOk:Bool) -> Void){
        
        let arrayOfDescriptions = RealmManager.SharedInstance.getAllSportsDescriptions()
        
        if arrayOfDescriptions.count>0{
            completion(true)
        }
        completion(false)
    }
}
