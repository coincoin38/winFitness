//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import FSCalendar
import JLToast

class SessionsViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    var daysArray: [String] = ["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]
    @IBOutlet weak var tableView: UITableView?
    
    let kShowDetailDay = "showDetailDay"
    let cellIdentifier = "dayIdentifier"

    var selectedDay: String = String()
    var selectedDate: NSDate = NSDate()
    var boolToast: Bool = Bool()
    var timer = NSTimer()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        getSports()
    }
    
    func getSports(){
        let sportsDataManager = SportsDataManager()
        sportsDataManager.getSports { (sportsArray) -> Void in
            
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(segue.identifier == kShowDetailDay) {
            
            let svc = segue.destinationViewController as! DayViewController
            svc.selectedDay   = selectedDay
            svc.selectedDate  = selectedDate
        }
    }
    
    func countUp() {
        timer.invalidate()
    }
    
    // MARK: - TableView delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = daysArray[indexPath.row]
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        //cell.setData(daysArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
