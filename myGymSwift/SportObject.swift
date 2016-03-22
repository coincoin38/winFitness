//
//  SportObject.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportObject: NSObject {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var _description = ""
    dynamic var color = UIColor()
    dynamic var image = ""

    func setSportForCell(sport: SportModel, completion: (sportObject: SportObject) -> Void) {
        
        let fullSport: SportObject = SportObject()
        
        RealmManager.SharedInstance.getSportDescriptionWithId(sport.description_id, completion: { (description) -> Void in
            if(description.count>0){
                fullSport._description = description[0].content
            }
        })
        
        fullSport.id               = sport.id
        fullSport.name             = sport.name
        fullSport.color            = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
        fullSport.image            = sport.image
        
        completion(sportObject: fullSport)
    }
}
