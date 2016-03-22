//
//  MainTabBarViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorSelection: UIColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        UITabBar.appearance().tintColor = colorSelection
        
        let firstTabBarItem:UITabBarItem  = tabBar.items![0]
        let secondTabBarItem:UITabBarItem = tabBar.items![1]
        let thirdTabBarItem:UITabBarItem  = tabBar.items![2]
        let fourthTabBarItem:UITabBarItem = tabBar.items![3]

        firstTabBarItem.selectedImage  = UIImage(named: ImagesConstants.tabBarSelectedImage0)
        secondTabBarItem.selectedImage = UIImage(named: ImagesConstants.tabBarSelectedImage1)
        thirdTabBarItem.selectedImage  = UIImage(named: ImagesConstants.tabBarSelectedImage2)
        fourthTabBarItem.selectedImage  = UIImage(named: ImagesConstants.tabBarSelectedImage3)

        firstTabBarItem.image  = UIImage(named: ImagesConstants.tabBarDefaultImage0)
        secondTabBarItem.image = UIImage(named: ImagesConstants.tabBarDefaultImage1)
        thirdTabBarItem.image  = UIImage(named: ImagesConstants.tabBarDefaultImage2)
        fourthTabBarItem.image  = UIImage(named: ImagesConstants.tabBarDefaultImage3)

        firstTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        secondTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        thirdTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        fourthTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
