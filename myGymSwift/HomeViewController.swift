//
//  HomeViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AlertViewControllerUtilProtocol {

    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    let kShowNews = "showNews"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        LoadingActivityIndicator.startAnimating();
        
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
    }
    
    func didClickFirstButton()
    {
        self.showNews();
    }
    
    func showNews()
    {
        self.LoadingActivityIndicator.stopAnimating();
        self.performSegue(withIdentifier: kShowNews, sender: self)
    }
}
