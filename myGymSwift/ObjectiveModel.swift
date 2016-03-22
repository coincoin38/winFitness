//
//  ObjectiveModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 24/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ObjectiveModel: Object {
    
    dynamic var id = ""
    dynamic var firstPart = ""
    dynamic var secondPart = ""
    dynamic var sport_id = ""
    
    func setData(dictionary: JSON) -> ObjectiveModel{
        
        id         = dictionary[ModelsConstants.kId].stringValue
        firstPart  = dictionary[ModelsConstants.kFirstPart].stringValue
        secondPart = dictionary[ModelsConstants.kSecondPart].stringValue
        sport_id   = dictionary[ModelsConstants.kSport_id].stringValue
        return self
    }
}
