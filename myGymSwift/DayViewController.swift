//
//  DayViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import JLToast

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sessionsArray: Array<SessionModel> = Array<SessionModel>()
    var selectedDay: String = String()
    var selectedDate : NSDate = NSDate()
    var timer = NSTimer()

    let cellIdentifier = "sessionIdentifier"
    let cellXib = "SessionTableViewCell"

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var dayPageIndicator: UIPageControl?

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerNib(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dateLabel?.text = selectedDay
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func detectAnotherDay(isNext:Bool){
        
        let components: NSDateComponents = NSDateComponents()
        components.setValue(-1, forComponent: NSCalendarUnit.Day);
        
        if(isNext){
            components.setValue(1, forComponent: NSCalendarUnit.Day);
        }
        
        let anotherDay   = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: selectedDate, options: NSCalendarOptions(rawValue: 0))
        updateDataWithAnotherDay(anotherDay!,isNext: isNext)
    }
    
    func updateDataWithAnotherDay(newDate:NSDate,isNext:Bool){
        
        RealmManager.SharedInstance.isSessionWithDate(newDate) { (sessions) -> Void in
            
            if(sessions.count>0){
                
                self.sessionsArray.removeAll()
                
                for session in sessions {
                    self.sessionsArray.append(session)
                }
                
                if(self.sessionsArray.count > 0) {
                    
                    if(isNext){
                        self.dayPageIndicator?.currentPage++
                    }
                    else{
                        self.dayPageIndicator?.currentPage--
                    }
                    self.selectedDay  = FormaterManager.SharedInstance.formatWeekDayAndDate(newDate)
                    self.dateLabel?.text = self.selectedDay
                    self.selectedDate = newDate
                    self.animateTable()
                }
            }
            else{
                if(!self.timer.valid){
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(JLToastDelay.ShortDelay+1.0, target: self, selector: "countUp", userInfo: nil, repeats: false)
                    JLToast.makeText(NSLocalizedString("NOTHING", comment:"")+"\n"+FormaterManager.SharedInstance.formatWeekDayAndDate(newDate), duration: JLToastDelay.ShortDelay).show()
                }
            }
        }
    }
    
    func countUp() {
        timer.invalidate()
    }
    
    func animateTable() {
        tableView!.reloadData()
        
        let cells = tableView!.visibleCells
        let tableHeight: CGFloat = tableView!.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK: - Actions

    @IBAction func rightGesture(sender: UISwipeGestureRecognizer) {
        if (self.dayPageIndicator?.currentPage != 0)
        {
            detectAnotherDay(false)
        }
    }
    
    @IBAction func leftGesture(sender: UISwipeGestureRecognizer) {
        detectAnotherDay(true)
    }
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - TableView delegate

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        cell.setData(sessionsArray[indexPath.row])
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
