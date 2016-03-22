//
//  NavBarManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 22/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class NavBarManager: NSObject {
    
    static let SharedInstance = NavBarManager()

    func resetNavBar(navigationController:UINavigationController){
        navigationController.navigationBar.tintColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextDefaultColor)
        navigationController.navigationBar.barTintColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarBackgroundColor)
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextDefaultColor)]
    }
    
    func configureNavBarWithColors(navigationController:UINavigationController, backgroundColor: UIColor, textColor:UIColor){
        navigationController.navigationBar.tintColor = textColor
        navigationController.navigationBar.barTintColor = backgroundColor
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
    }
}
