//
//  HomeViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 18/08/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    let kShowNews = "showNews"

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingActivityIndicator.startAnimating();
        FBManager.SharedInstance.FBToken { (bool) in
            
            if(bool)
            {
                FBManager.SharedInstance.FBFeed({ (feed) in
                    self.showNews();
                })
            }
            else
            {
                self.showNews();
            }
        }
    }

    func showNews()
    {
        self.LoadingActivityIndicator.stopAnimating();
        self.performSegueWithIdentifier(kShowNews, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
