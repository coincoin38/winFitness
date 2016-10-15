//
//  RootViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 07/10/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import APESuperHUD

class RootViewController: UIViewController{
    
    func APESuperHUDSplashScreen() {
        
        APESuperHUD.appearance.backgroundColor = UIColor.white
        APESuperHUD.appearance.iconWidth = self.view.frame.size.width/2
        APESuperHUD.appearance.iconHeight = self.view.frame.size.width/2
        APESuperHUD.appearance.hudSquareSize = self.view.frame.size.width/1.25
        APESuperHUD.appearance.textColor =  FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        APESuperHUD.appearance.shadow = false
    }
    
    func APESuperHUDDefault() {
        
        APESuperHUD.appearance.textColor = UIColor.black
        APESuperHUD.appearance.iconWidth = 48
        APESuperHUD.appearance.iconHeight = 48
        APESuperHUD.appearance.hudSquareSize = 144
        APESuperHUD.appearance.loadingActivityIndicatorColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
    }
}
