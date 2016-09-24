//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class DaysViewController: UIViewController {

    var daysArray: [String] = ["LUNDI","MARDI","MERCREDI","JEUDI","VENDREDI","SAMEDI"]
    @IBOutlet weak var tableView: UITableView?
    
    let kShowDetailDay = "showDetailDay"
    let cellIdentifier = "dayIdentifier"
    let cellXib = "DayTableViewCell"

    var selectedDay: String = String()
    var selectedDate: Date = Date()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        //getSports()
    }
    
    func getSports(){
        let sportsDataManager = SportsDataManager()
        sportsDataManager.getSports { (sportsArray) -> Void in
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == kShowDetailDay) {
            
            let svc = segue.destination as! DayViewController
            svc.selectedDay   = selectedDay
            svc.selectedDate  = selectedDate
        }
    }
    
    // MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DayTableViewCell

        cell.dayLabel?.text = daysArray[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
