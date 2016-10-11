//
//  NewsDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import APESuperHUD

class NewsDetailsViewController: UIViewController, UIWebViewDelegate, AlertViewControllerUtilProtocol {
    
    var news: FBFeedModel!
    var loaded : Bool = true
    let navBar = NavBarManager()
    let urlPost = URL(string:String(format: NetworkConstants.FB_open_profile,NetworkConstants.FB_profile_id))!
    let alert = AlertViewControllerUtil()
    
    @IBOutlet weak var bodyNewsWebView: UIWebView!
    @IBOutlet weak var facebookButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        alert.delegate = self
        setIHM()
    }
    
    func setIHM(){
        
        title = String(format:NSLocalizedString("NEWS_TITLE", comment:""),FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(news.created_time!)))
        
        navBar.configureNavBarWithColors(navigationController!,
                                         backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor),
                                         textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
        
        
        let modifiedURLString = String(format: NetworkConstants.FB_webview_news_detail,news.full_picture!,news.feedBody())
        bodyNewsWebView.delegate = self
        bodyNewsWebView.loadHTMLString(modifiedURLString, baseURL: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: loaded)
        UIApplication.shared.statusBarStyle = .lightContent
        if loaded {
            loaded = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    func webViewDidStartLoad(_ webView : UIWebView) {
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: NSLocalizedString("LOADING_NEW", comment:""), presentingView: self.view)
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion:nil)
        facebookButton.isHidden = false
    }
    
    @IBAction func openFacebook(sender: UIButton) {
        
        if UIApplication.shared.canOpenURL(urlPost) {
            UIApplication.shared.openURL(urlPost)
        }
        else
        {
            self.present(alert.FBAppstoreAlertController(), animated: true, completion:nil)
        }
    }
    
    func didClickFirstButton() {}
    
    func didClickSecondButton() {
        UIApplication.shared.openURL(URL (string: NetworkConstants.FB_appstore)!)
    }
}
