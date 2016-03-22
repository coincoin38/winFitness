//
//  SportsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var sportsArray: Array<SportModel> = Array<SportModel>()
    private let reuseIdentifier = "SportIdentifier"
    let kShowDetailSport = "showDetailSport"
    @IBOutlet weak var sportsCollectionView: UICollectionView?
    var sport: SportModel = SportModel()
    var objectivesArray: Array<ObjectiveModel> = Array<ObjectiveModel>()
    let sportsDataManager = SportsDataManager()
    let sportsDescriptionsDataManager = SportsDescriptionsDataManager()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
        getSportsDescriptions()
    }
    
    func setIHM(){
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        sportsCollectionView?.registerNib(UINib(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    func getSports(){
        
        sportsDataManager.getSports { (sportsArray) -> Void in
            self.sportsArray = sportsArray
            self.sportsCollectionView?.reloadData()
        }
    }
    
    func getSportsDescriptions(){
        
        sportsDescriptionsDataManager.getSportsDescriptions { (isOk) -> Void in
        
            if isOk{
                self.getSports()
            }
        }
    }
    
    // MARK: - Collection delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SportCollectionViewCell
        cell.setData(sportsArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.sport = self.sportsArray[indexPath.row]
        self.sportsDataManager.getObjectivesFromDB(self.sport, completion: { (objectives) -> Void in
            self.objectivesArray = objectives
        })
        self.performSegueWithIdentifier(self.kShowDetailSport, sender: self)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailSport) {
            let sdvc = segue.destinationViewController as! SportDetailsViewController
            sdvc.sport = sport
            sdvc.objectivesArray = objectivesArray
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

