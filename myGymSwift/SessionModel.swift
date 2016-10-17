//
//  SessionModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SessionModel: Object {
    
    dynamic var id = ""
    dynamic var sport_id = ""
    dynamic var from = ""
    dynamic var duration = ""
    dynamic var attendance = ""
    dynamic var day = ""
    
    func setData(_ dictionary: JSON) -> SessionModel{
        
        // Format string to date
        id         = dictionary[ModelsConstants.kId].stringValue
        sport_id   = dictionary[ModelsConstants.kSport_id].stringValue
        from       = dictionary[ModelsConstants.kFrom].stringValue
        duration   = dictionary[ModelsConstants.kDuration].stringValue
        attendance = dictionary[ModelsConstants.kAttendance].stringValue
        day        = dictionary[ModelsConstants.kDay].stringValue
        return self
    }
}
