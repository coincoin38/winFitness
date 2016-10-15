//
//  SportDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 21/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportDetailsViewController: UIViewController,UIGestureRecognizerDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var sport: SportModel = SportModel()
    var loaded : Bool = true
    @IBOutlet weak var sportDescriptionTextView: UITextView!
    @IBOutlet weak var objectivesCollectionView: UICollectionView?
    fileprivate let reuseIdentifier = "ObjectiveIdentifier"
    var objectivesArray: Array<ObjectiveModel> = Array<ObjectiveModel>()
    let navBar = NavBarManager()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setIHM()
    }
    
    func setIHM(){
        RealmManager.SharedInstance.getSportDescriptionWithId(sport.description_id, completion: { (description) -> Void in
            if(description.count>0){
                self.sportDescriptionTextView.text = description[0].content
            }
        })
        
        objectivesCollectionView?.register(UINib(nibName: "ObjectiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: loaded)
        configureStyleNavBar()
        if loaded {
            loaded = false
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }

    func configureStyleNavBar(){
        
        //NavBar
        title = sport.name
        navBar.configureNavBarWithColors(navigationController!, backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(sport.color), textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
        }
    
    // MARK: - Actions
    
    func back(_ sender: UIBarButtonItem) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            let _ = navigationController?.popViewController(animated: true)
            return true
        }
        return false
    }
    
    // MARK: - Collection delegate

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectivesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ObjectiveCollectionViewCell
        cell.setData(objectivesArray[(indexPath as NSIndexPath).row], sport: sport)

        return cell
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
