//
//  DayTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 01/05/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var RPMImageView: UIImageView!
    @IBOutlet weak var LESMILLSImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        
        let tapGestureRecognizerRPM = UITapGestureRecognizer(target:self, action:#selector(openRPM))
        let tapGestureRecognizerLESMILLS = UITapGestureRecognizer(target:self, action:#selector(openLESMILLS))

        RPMImageView.addGestureRecognizer(tapGestureRecognizerRPM)
        LESMILLSImageView.addGestureRecognizer(tapGestureRecognizerLESMILLS)
    }

    func openRPM(){
        print("open RPM")
    }
    
    func openLESMILLS(){
        print("open LESMILLS")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(dayOfTheWeek: String, index: Int)
    {
        dayLabel?.text = dayOfTheWeek
        
        let currentDay : Int = FormaterManager.SharedInstance.getDayOfWeek()!
        let trueIndex : Int = index+2
        
        if (currentDay == trueIndex)
        {
            dayLabel?.textColor = UIColor.black
        }
        else if(currentDay > trueIndex)
        {
            dayLabel?.textColor = UIColor.darkGray
        }
    }
}
