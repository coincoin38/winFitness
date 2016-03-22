//
//  ObjectiveObject.swift
//  myGymSwift
//
//  Created by julien gimenez on 25/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class ObjectivesObject: NSObject {

    func setObjectives(sport: SportModel, completion: (objectivesObject: Array<ObjectiveObject>) -> Void) {
        
        RealmManager.SharedInstance.getObjectivesWithSportId(sport.id, completion: { (objectives) -> Void in

            var objectivesArray: Array<ObjectiveObject> = Array<ObjectiveObject>()

            for objective in objectives{
                
                let obj: ObjectiveObject = ObjectiveObject()
                obj.firstPart  = objective.firstPart
                obj.secondPart = objective.secondPart
                obj.sportColor = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
                
                objectivesArray.append(obj)
                
            }
            completion(objectivesObject: objectivesArray)
        })
    }
}
