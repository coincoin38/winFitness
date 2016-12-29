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

    let cellIdentifier = "sessionIdentifier"
    let cellXib = "SessionTableViewCell"

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var dateLabel: UILabel?

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dateLabel?.text = selectedDay
        
        RealmManager.SharedInstance.isSessionWithDate(selectedDay) { (sessions) -> Void in
            
            if(sessions.count>0){
                
                for session in sessions {
                    self.sessionsArray.append(session)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    // MARK: - Animation

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
    
    // MARK: - Actions
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
