//
//  NewsDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var news: NewsModel = NewsModel()
    @IBOutlet weak var bodytNewsTextView: UITextView!
    @IBOutlet weak var dateNewsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
    }
    
    func setIHM(){
        bodytNewsTextView.scrollEnabled = false
        title = news.title
        bodytNewsTextView.text = news._description
        NavBarManager.SharedInstance.configureNavBarWithColors(navigationController!, backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
, textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))

    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        //Fix pour empêcher le scroll to bottom par défaut
        bodytNewsTextView.scrollEnabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
}