//
//  DayViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sessionsArray: Array<SessionModel> = Array<SessionModel>()
    var selectedDay: String = String()
    var selectedDate : Date = Date()
    var timer = Timer()

    let cellIdentifier = "sessionIdentifier"
    let cellXib = "SessionTableViewCell"

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var dayPageIndicator: UIPageControl?

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dateLabel?.text = selectedDay
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func detectAnotherDay(_ isNext:Bool){
        
        /*let components: DateComponents = DateComponents()
        (components as NSDateComponents).setValue(-1, forComponent: Calendar.init.day);
        
        if(isNext){
            (components as NSDateComponents).setValue(1, forComponent: Calendar.init.day);
        }
        
        let anotherDay   = (Calendar.current as NSCalendar).date(byAdding: components, to: selectedDate, options: Calendar.Options(rawValue: 0))
        updateDataWithAnotherDay(anotherDay!,isNext: isNext)*/
    }
    
    func updateDataWithAnotherDay(_ newDate:Date,isNext:Bool){
        
        RealmManager.SharedInstance.isSessionWithDate(newDate) { (sessions) -> Void in
            
            if(sessions.count>0){
                
                self.sessionsArray.removeAll()
                
                for session in sessions {
                    self.sessionsArray.append(session)
                }
                
                if(self.sessionsArray.count > 0) {
                    
                    if(isNext){
                        self.dayPageIndicator?.currentPage+=1
                    }
                    else{
                        self.dayPageIndicator?.currentPage-=1
                    }
                    self.selectedDay  = FormaterManager.SharedInstance.formatWeekDayAndDate(newDate)
                    self.dateLabel?.text = self.selectedDay
                    self.selectedDate = newDate
                    self.animateTable()
                }
            }
            else{
                if(!self.timer.isValid){
                    /*self.timer = NSTimer.scheduledTimerWithTimeInterval(JLToastDelay.ShortDelay+1.0, target: self, selector: #selector(DayViewController.countUp), userInfo: nil, repeats: false)
                    JLToast.makeText(NSLocalizedString("NOTHING", comment:"")+"\n"+FormaterManager.SharedInstance.formatWeekDayAndDate(newDate), duration: JLToastDelay.ShortDelay).show()*/
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
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK: - Actions

    @IBAction func rightGesture(_ sender: UISwipeGestureRecognizer) {
        if (self.dayPageIndicator?.currentPage != 0)
        {
            detectAnotherDay(false)
        }
    }
    
    @IBAction func leftGesture(_ sender: UISwipeGestureRecognizer) {
        detectAnotherDay(true)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SessionTableViewCell
        cell.setData(sessionsArray[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
