//
//  SportModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 06/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SportModel: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var description_id = ""
    dynamic var color = ""
    dynamic var image = ""
    
    func setData(dictionary: JSON) -> SportModel{
        
        id             = dictionary[ModelsConstants.kId].stringValue
        name           = dictionary[ModelsConstants.kName].stringValue
        description_id = dictionary[ModelsConstants.kDescription_id].stringValue
        color          = dictionary[ModelsConstants.kColor].stringValue
        image          = dictionary[ModelsConstants.kImage].stringValue
        return self
    }
}
