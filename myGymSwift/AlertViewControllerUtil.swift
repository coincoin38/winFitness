//
//  AlertViewControllerUtil.swift
//  myGymSwift
//
//  Created by SQLI51109 on 07/10/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

@objc protocol AlertViewControllerUtilProtocol {
    @objc optional func didClickFirstButton()
    @objc optional func didClickSecondButton()
}

class AlertViewControllerUtil {
    
    var delegate: AlertViewControllerUtilProtocol?
    
    func FBTokenErrorAlertController ()->UIAlertController
    {
        return AlertOneButton(title: NSLocalizedString("FACEBOOK", comment:""),
                              message: NSLocalizedString("ERROR_TOKEN", comment:""),
                              button: NSLocalizedString("OK", comment:""))
    }
    
    func FBAppstoreAlertController ()->UIAlertController
    {
        return AlertTwoButtons(title: NSLocalizedString("FACEBOOK", comment:""),
                               message: NSLocalizedString("FB_INSTALLATION", comment:""),
                               button1: NSLocalizedString("NO", comment:""),
                               button2: NSLocalizedString("YES", comment:""))
    }
    
    func AlertOneButton (title:String, message:String, button:String)->UIAlertController
    {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: button,
                                     style: .default)
        {
            (action:UIAlertAction!) in self.delegate?.didClickFirstButton!();
        }
        
        alertController.addAction(OKAction)
        
        return alertController
    }
    
    func AlertTwoButtons (title:String, message:String, button1:String, button2:String)->UIAlertController
    {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: button1,
                                     style: .default)
        {
            (action:UIAlertAction!) in self.delegate?.didClickFirstButton!();
        }
        
        let secondAction = UIAlertAction(title: button2,
                                     style: .default)
        {
            (action:UIAlertAction!) in self.delegate?.didClickSecondButton!();
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        
        return alertController
    }
}
