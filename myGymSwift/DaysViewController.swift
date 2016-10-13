//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var daysArray: [String] = ["LUNDI","MARDI","MERCREDI","JEUDI","VENDREDI","SAMEDI"]
    @IBOutlet weak var tableView: UITableView?
    
    let kShowDetailDay = "showDetailDay"
    let cellIdentifier = "dayIdentifier"
    let cellXib = "DayTableViewCell"
    
    var cellSize : CGFloat = 0;
    var selectedDay: String = String()
    var selectedDate: Date = Date()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: cellXib, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.tableFooterView = UIView(frame: .zero)
        cellSize = (view.frame.size.height-UIApplication.shared.statusBarFrame.size.height-(self.tabBarController?.tabBar.frame.height)!)/CGFloat(daysArray.count)
        animateTable()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DayTableViewCell
        cell.setData(dayOfTheWeek: daysArray[(indexPath as NSIndexPath).row], index: (indexPath as NSIndexPath).row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return cellSize
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
