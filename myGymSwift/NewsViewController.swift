//
//  NewsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 10/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let cellIdentifier = "newsIdentifier"
    let cellXib = "NewsTableViewCell"
    let cellXibV2 = "NewsTableViewCellV2"

    var refreshControl:UIRefreshControl!
    
    var FBFeed: Array<FBFeedModel>! = Array<FBFeedModel>()
    
    let kShowDetailNews = "showDetailNews"

    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
        getNews()
    }
    
    func setIHM(){
        
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL_TO_REFRESH", comment:""))
        self.refreshControl.addTarget(self, action: #selector(NewsViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        tableView?.addSubview(refreshControl)
    }
    
    func getNews(){
        
        FBFeed = FBManager.SharedInstance.FBFeed
        self.tableView?.reloadData()
        let range = NSMakeRange(0, 1)
        let sections = IndexSet(integersIn: range.toRange() ?? 0..<0)
        self.tableView?.reloadSections(sections, with: .fade)
        self.refreshControl.endRefreshing()
    }
    
    func refresh(_ sender:AnyObject)
    {
        getNews()
    }
    
    // MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FBFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        cell.setData(FBFeed[(indexPath as NSIndexPath).row])
        
        if let urlString = FBFeed[(indexPath as NSIndexPath).row].full_picture {
            cell.newsImage.af_setImage(withURL: URL(string: urlString)!,placeholderImage: UIImage(named: "logo_winfitness"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kShowDetailNews, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == kShowDetailNews) {
            let ndvc = segue.destination as! NewsDetailsViewController
            ndvc.news = FBFeed[((tableView?.indexPathForSelectedRow as NSIndexPath?)?.row)!]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
