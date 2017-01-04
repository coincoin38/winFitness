//
//  ContactModel.swift
//  myGymSwift
//
//  Created by SQLI51109 on 04/01/2017.
//  Copyright © 2017 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ContactModel: Object {
    
    dynamic var id = ""
    dynamic var club = ""
    dynamic var district = ""
    dynamic var address = ""
    dynamic var informations = ""
    dynamic var trainings = ""

    func setData(_ dictionary: JSON) -> ContactModel{
        
        id           = dictionary[ModelsConstants.kId].stringValue
        club         = dictionary[ModelsConstants.kClub].stringValue
        district     = dictionary[ModelsConstants.kDistrict].stringValue
        address      = dictionary[ModelsConstants.kAddress].stringValue
        informations = dictionary[ModelsConstants.kInformations].stringValue
        trainings    = dictionary[ModelsConstants.kTrainings].stringValue

        return self
    }
}
