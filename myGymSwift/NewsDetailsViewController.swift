//
//  NewsDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 19/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import APESuperHUD

class NewsDetailsViewController: UIViewController, UIWebViewDelegate {
    
    var news: FBFeedModel!
    var loaded : Bool = true
    let navBar = NavBarManager()
    @IBOutlet weak var bodyNewsWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
    }
    
    func setIHM(){
        
        title = "News du "+FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(news.created_time!))
        
        navBar.configureNavBarWithColors(navigationController!,
                                         backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor),
                                         textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
        
        
        let bodyHtml = "<html><body style=\"margin: 0; padding: 0;\"><img src=\"%@\" style=\"width:100%%;\"><br><p style=\"text-align:justify;margin: 5; padding: 5;\">%@</p></body></html>";
        let modifiedURLString = String(format: bodyHtml,news.full_picture!,news.feedBody())
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
    }
}
