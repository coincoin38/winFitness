//
//  SessionTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 05/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var attendanceView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(_ session: SessionModel) {
        
        RealmManager.SharedInstance.getSportWithId(session.sport_id) { (sport) -> Void in
            if(sport.count>0){
                self.sessionLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(sport[0].color)
                self.sessionLabel?.text      = sport[0].name
            }
        }

        fromLabel?.text         = session.from
        durationLabel?.text     = session.duration+NSLocalizedString("MINUTES_SHORT", comment:"")

        if(Int(session.attendance) == 0){
            attendanceView.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.tableViewCellFullAttendanceColor)
        }
        else{
            attendanceView.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.tableViewCellLowAttendanceColor)
        }
    }
}
