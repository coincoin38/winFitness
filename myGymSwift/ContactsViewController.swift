//
//  ContactViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 27/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let cellIdentifier = "contactsIdentifier"
    let cellXib = "ContactsTableViewCell"
    let cellSize : CGFloat = 300;
    let contactsManager = ContactsManager()

    var ContactFeed: Array<ContactModel> = []
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setIHM()
        getContacts()
    }
    
    func setIHM(){
        
        view.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        headerView?.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func getContacts(){
        
        contactsManager.getContacts { (contactsArray) -> Void in
            self.ContactFeed = contactsArray
            self.tableView?.reloadData()
        }
    }
    
    // MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ContactsTableViewCell
        cell.setData(ContactFeed[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return cellSize
    }
    
    // MARK: - Actions
    
    func openPlan(_ gr:UITapGestureRecognizer)
    {
        let lat1 : NSString = "45.744127"
        let lng1 : NSString = "4.871262"
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "WIN FITNESS"
        mapItem.openInMaps(launchOptions: options)
        
    }

}
