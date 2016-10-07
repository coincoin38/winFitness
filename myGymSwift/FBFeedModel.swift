//
//  FBFeedModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class FBFeedModel: NSObject {

    dynamic var actions      : Array<[String: AnyObject]>? = Array<[String: AnyObject]>()
    dynamic var created_time : String? = String()
    dynamic var _description : String? = String()
    dynamic var message      : String? = String()
    dynamic var full_picture : String? = String()
    dynamic var id           : String? = String()
    dynamic var type         : String? = String()

    init(resultModel:NSDictionary) {
        
        super.init()
        
        id           = resultModel[ModelsConstants.kId]as? String
        _description = resultModel[ModelsConstants.kDescription] as? String
        message      = resultModel[ModelsConstants.kMessage] as? String
        created_time = resultModel[ModelsConstants.kCreated_time]as? String
        full_picture = resultModel[ModelsConstants.kFull_picture]as? String
        type         = resultModel[ModelsConstants.kType]as? String
        actions      = resultModel[ModelsConstants.kActions]as? Array<[String: AnyObject]>
    }
    
    func feedBody()->String
    {
        if (self.message != nil && self._description != nil)
        {
            return self.message! + "\n" + self._description!
        }
        
        if (self.message != nil)
        {
            return self.message!
        }
        
        if (self._description != nil)
        {
            return self._description!
        }
        
        return ""
    }
}
