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
        FBManager.SharedInstance.getFBToken { (bool) in
            
            if(bool)
            {
                FBManager.SharedInstance.getFBNews({ (news) in
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
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("wtf")
    }

}
