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
    @IBOutlet weak var sportDescriptionTextView: UITextView!
    @IBOutlet weak var objectivesCollectionView: UICollectionView?
    private let reuseIdentifier = "ObjectiveIdentifier"
    var objectivesArray: Array<ObjectiveModel> = Array<ObjectiveModel>()


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
        
        sportDescriptionTextView.textAlignment = .Justified
        sportDescriptionTextView.font = UIFont.systemFontOfSize(14, weight: 0)
        objectivesCollectionView?.registerNib(UINib(nibName: "ObjectiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        configureStyleNavBar()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
       // NavBarManager.SharedInstance.resetNavBar(navigationController!)
    }

    func configureStyleNavBar(){
        
        //NavBar
        title = sport.name
        NavBarManager.SharedInstance.configureNavBarWithColors(navigationController!, backgroundColor: FormaterManager.SharedInstance.uicolorFromHexa(sport.color), textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //Back button
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("BACK", comment:""), style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        newBackButton.setTitleTextAttributes([NSForegroundColorAttributeName: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor),NSFontAttributeName:UIFont.systemFontOfSize(15, weight: 0)], forState: UIControlState.Normal)

        self.navigationItem.leftBarButtonItem = newBackButton;
        
        
        //StatusBar
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    // MARK: - Actions
    
    func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            navigationController?.popViewControllerAnimated(true)
            return true
        }
        return false
    }
    
    // MARK: - Collection delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectivesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ObjectiveCollectionViewCell
        cell.setData(objectivesArray[indexPath.row], sport: sport)

        return cell
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
