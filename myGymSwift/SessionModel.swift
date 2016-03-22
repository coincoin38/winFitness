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
    dynamic var location = ""
    dynamic var teacher_id = ""
    dynamic var attendance = ""
    dynamic var day = NSDate()
    
    func setData(dictionary: JSON) -> SessionModel{
        
        // Format string to date
        let date = FormaterManager.SharedInstance.formatyyyMMddFromString(dictionary[ModelsConstants.kDay].stringValue)
        id         = dictionary[ModelsConstants.kId].stringValue
        sport_id   = dictionary[ModelsConstants.kSport_id].stringValue
        from       = dictionary[ModelsConstants.kFrom].stringValue
        duration   = dictionary[ModelsConstants.kDuration].stringValue
        location   = dictionary[ModelsConstants.kLocation].stringValue
        teacher_id = dictionary[ModelsConstants.kTeacher_id].stringValue
        attendance = dictionary[ModelsConstants.kAttendance].stringValue
        day        = date
        return self
    }
}
