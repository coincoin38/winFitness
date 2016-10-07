//
//  AlertViewControllerUtil.swift
//  myGymSwift
//
//  Created by SQLI51109 on 07/10/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

protocol AlertViewControllerUtilProtocol {
    func didClickFirstButton()
}

class AlertViewControllerUtil {
    
    var delegate: AlertViewControllerUtilProtocol?
    
    func FBTokenErrorAlertController ()->UIAlertController
    {
        return AlertOneButton(title: NSLocalizedString("FACEBOOK", comment:""),
                              message: NSLocalizedString("ERROR_TOKEN", comment:""),
                              button: NSLocalizedString("OK", comment:""))
    }
    
    func AlertOneButton (title:String, message:String, button:String)->UIAlertController
    {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: button,
                                     style: .default)
        {
            (action:UIAlertAction!) in self.delegate?.didClickFirstButton();
        }
        
        alertController.addAction(OKAction)
        
        return alertController
    }
}
