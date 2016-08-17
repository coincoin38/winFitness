//
//  NewsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 10/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import SwiftyJSON

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let cellIdentifier = "newsIdentifier"
    let cellXib = "NewsTableViewCell"
    let cellXibV2 = "NewsTableViewCellV2"

    var refreshControl:UIRefreshControl!
    
    var newsArray: Array<NewsModel> = Array<NewsModel>()
    let newsDataManager = NewsDataManager()
    
    let kShowDetailNews = "showDetailNews"

    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
        getNews()
    }
    
    func setIHM(){
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        tableView?.registerNib(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL_TO_REFRESH", comment:""))
        self.refreshControl.addTarget(self, action: #selector(NewsViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView?.addSubview(refreshControl)
    }
    
    func getNews(){
    
        //newsDataManager.getNewsOrdered { (newsArray) -> Void in
          //  self.newsArray = newsArray
            self.tableView?.reloadData()
            let range = NSMakeRange(0, 1)
            let sections = NSIndexSet(indexesInRange: range)
            self.tableView?.reloadSections(sections, withRowAnimation: .Fade)
            self.refreshControl.endRefreshing()
        
        //}
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/oauth/access_token",
                                                                 parameters:["client_id":"286786961691987",
                "client_secret":"31bed12dbc2fd2268613d27fe87b3405",
                "grant_type":"client_credentials"])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let access_token = result.valueForKey("access_token") as! String
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "1207136935980128/feed",
                    parameters: ["limit" : "5","fields" : "full_picture,actions,description,created_time" ],
                    tokenString : access_token as String,
                    version :"v2.7",
                    HTTPMethod: "GET")
                
                graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                    
                    if ((error) != nil)
                    {
                        print("Error: \(error)")
                    }
                    else
                    {
                        print("Result: \(result)")
                    }
                })
            }
        })
    }
    
    func refresh(sender:AnyObject)
    {
        getNews()
    }
    
    // MARK: - TableView delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! NewsTableViewCell
        cell.setData(newsArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(kShowDetailNews, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(segue.identifier == kShowDetailNews) {
            let ndvc = segue.destinationViewController as! NewsDetailsViewController
            ndvc.news = newsArray[(tableView?.indexPathForSelectedRow?.row)!]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
