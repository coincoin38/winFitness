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
    fileprivate let reuseIdentifier = "SportIdentifier"
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
        
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        sportsCollectionView?.register(UINib(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportCollectionViewCell
        cell.setData(sportsArray[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationItem.title = ""
        self.sport = self.sportsArray[(indexPath as NSIndexPath).row]
        self.sportsDataManager.getObjectivesFromDB(self.sport, completion: { (objectives) -> Void in
            self.objectivesArray = objectives
        })
        self.performSegue(withIdentifier: self.kShowDetailSport, sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailSport) {
            let sdvc = segue.destination as! SportDetailsViewController
            sdvc.sport = sport
            sdvc.objectivesArray = objectivesArray
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

