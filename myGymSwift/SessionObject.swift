//
//  SessionObject.swift
//  myGymSwift
//
//  Created by julien gimenez on 06/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SessionObject: NSObject {
    dynamic var from = ""
    dynamic var duration = ""
    dynamic var sportName = ""
    dynamic var teacherName = ""
    dynamic var attendance = ""
    dynamic var colorSport = UIColor()
    
    func setSessionForCell(session: SessionModel, completion: (sessionObject: SessionObject) -> Void) {
        
        let fullSession: SessionObject = SessionObject()
        fullSession.from       = session.from
        fullSession.duration   = session.duration
        fullSession.attendance = session.attendance

        RealmManager.SharedInstance.getSportWithId(session.sport_id) { (sport) -> Void in
            if(sport.count>0){
                fullSession.sportName  = sport[0].name
                fullSession.colorSport = FormaterManager.SharedInstance.uicolorFromHexa(sport[0].color)
            }
        }
        RealmManager.SharedInstance.getTeacherWithId(session.teacher_id) { (teacher) -> Void in
            if(teacher.count>0){
                fullSession.teacherName = teacher[0].name + " " + teacher[0].first_name
            }
        }
        completion(sessionObject: fullSession)
    }
}
