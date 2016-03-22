//
//  NewsModel.swift
//  myGymSwift
//
//  Created by SQLI51109 on 06/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class NewsModel: Object {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var _description = ""
    dynamic var day = NSDate()
    
    func setData(dictionary: JSON) -> NewsModel{
        
        let date = FormaterManager.SharedInstance.formatServerDateFromString(dictionary[ModelsConstants.kDay].stringValue)
        id            = dictionary[ModelsConstants.kId].stringValue
        title         = dictionary[ModelsConstants.kTitle].stringValue
        _description  = dictionary[ModelsConstants.kDescription].stringValue
        day           = date
        return self
    }
}