//
//  ObjectiveCollectionViewCell.swift
//  myGymSwift
//
//  Created by SQLI51109 on 22/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class ObjectiveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var firstPartLabel: UILabel!
    @IBOutlet weak var secondePartLabel: UILabel!
    @IBOutlet weak var colorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(objective: ObjectiveModel, sport:SportModel) {
        firstPartLabel?.text      = objective.firstPart
        secondePartLabel?.text    = objective.secondPart
        colorView.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
    }
}
