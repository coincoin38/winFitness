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

    @IBOutlet weak var myCalendar: FSCalendar?
    let kShowDetailDay = "showDetailDay"
    var selectedDay: String = String()
    var selectedDate: NSDate = NSDate()
    var sessionsArray: Array<SessionModel> = Array<SessionModel>()
    var boolToast: Bool = Bool()
    var timer = NSTimer()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        myCalendar?.locale = NSLocale.init(localeIdentifier: FormaterManager.SharedInstance.fr_BI)
        myCalendar?.delegate = self
        myCalendar?.dataSource = self
        myCalendar?.appearance.headerMinimumDissolvedAlpha = 0.0
        myCalendar?.appearance.headerDateFormat = FormaterManager.SharedInstance.MMM
        myCalendar?.userInteractionEnabled = false
        getSports()
    }
    
    func getSports(){
        let sportsDataManager = SportsDataManager()
        sportsDataManager.getSports { (sportsArray) -> Void in
            self.myCalendar?.userInteractionEnabled = true
        }
    }
    
    // MARK: - FSCalendar delegate
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {

        selectedDay =  FormaterManager.SharedInstance.formatWeekDayAndDate(date)
        selectedDate = date
        
        RealmManager.SharedInstance.isSessionWithDate(date) { (sessions) -> Void in
            
            self.sessionsArray.removeAll()
            
            for session in sessions {
                self.sessionsArray.append(session)
            }
            
            if(sessions.count > 0) {
                self.performSegueWithIdentifier(self.kShowDetailDay, sender: self)
            }
            else{
                
                if(!self.timer.valid){
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(JLToastDelay.ShortDelay+1.0, target: self, selector: "countUp", userInfo: nil, repeats: false)
                    JLToast.makeText(NSLocalizedString("NOTHING", comment:"")+"\n"+self.selectedDay, duration: JLToastDelay.ShortDelay).show()
                }
            }
        }
    }
    
    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        
        return NSDate()
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        
        let date = NSCalendar.currentCalendar().dateByAddingUnit(.WeekOfMonth, value: 1, toDate: NSDate(), options: [])

        return date
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if(segue.identifier == kShowDetailDay) {
            
            let svc = segue.destinationViewController as! DayViewController
            svc.sessionsArray = sessionsArray
            svc.selectedDay   = selectedDay
            svc.selectedDate  = selectedDate
        }
    }
    
    func countUp() {
        timer.invalidate()
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
