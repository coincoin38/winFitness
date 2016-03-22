//
//  SportDescriptionModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 24/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SportDescriptionModel: Object {
    
    dynamic var key_sport = ""
    dynamic var content = ""
    
    func setData(dictionary: JSON) -> SportDescriptionModel{
        
        key_sport = dictionary[ModelsConstants.kKey_sport].stringValue
        content   = dictionary[ModelsConstants.kContent].stringValue
        return self
    }
}
