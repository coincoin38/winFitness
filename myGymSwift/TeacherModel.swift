//
//  TeacherModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class TeacherModel: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var first_name = ""
    dynamic var _description = ""
    dynamic var photo = ""
    dynamic var agency = ""
    
    func setData(dictionary: JSON) -> TeacherModel{
        
        id           = dictionary[ModelsConstants.kId].stringValue
        name         = dictionary[ModelsConstants.kName].stringValue
        first_name   = dictionary[ModelsConstants.kFirst_name].stringValue
        _description = dictionary[ModelsConstants.k_description].stringValue
        photo        = dictionary[ModelsConstants.kPhoto].stringValue
        agency       = dictionary[ModelsConstants.kAgency].stringValue
        return self
    }
}
