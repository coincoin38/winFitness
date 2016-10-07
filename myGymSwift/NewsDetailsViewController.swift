//
//  NewsDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var news: FBFeedModel!
    var loaded : Bool = true
    let navBar = NavBarManager()
    @IBOutlet weak var bodytNewsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
    }
    
    func setIHM(){
        bodytNewsTextView.isScrollEnabled = false
        
        title = "News du "+FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(news.created_time!))
        bodytNewsTextView.text = news.feedBody()
        navBar.configureNavBarWithColors(navigationController!,
                                         backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor),
                                         textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: loaded)
        UIApplication.shared.statusBarStyle = .lightContent
        if loaded {
            loaded = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Fix pour empêcher le scroll to bottom par défaut
        bodytNewsTextView.isScrollEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }
}
