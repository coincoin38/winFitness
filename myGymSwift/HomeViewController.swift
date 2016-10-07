//
//  HomeViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import APESuperHUD

class HomeViewController: RootViewController, AlertViewControllerUtilProtocol {

    let kShowNews = "showNews"

    override func viewDidLoad()
    {
        super.viewDidLoad()
 
        APESuperHUDSplashScreen()
        APESuperHUD.showOrUpdateHUD(icon: UIImage(named: "winfitnesslogo")!, message: NSLocalizedString("CATCH_PHRASE", comment:""), presentingView: self.view, completion: {
            
            FBTokenManager.SharedInstance.FBToken { (success) in
                
                if(success)
                {
                    self.showNews();
                }
                else
                {
                    let alert = AlertViewControllerUtil()
                    alert.delegate = self
                    self.present(alert.FBTokenErrorAlertController(), animated: true, completion:nil)
                }
            }
        })
    }
    
    func didClickFirstButton()
    {
        self.showNews();
    }
    
    func showNews()
    {
        self.performSegue(withIdentifier: kShowNews, sender: self)
    }
}
