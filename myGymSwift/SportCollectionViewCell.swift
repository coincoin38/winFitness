//
//  SportCollectionViewCell.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var voileView: UIView!
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ sport: SportModel) {

        titleLabel?.text           = sport.name
        footerView.backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
        footerView.alpha           = 0.75
        sportImage.image           = UIImage(named: sport.image)
        voileView.backgroundColor  = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                super.isHighlighted = true
                UIView.animate(withDuration: 0.25, animations: {
                    self.voileView.alpha = 0.75
                })
            } else if newValue == false {
                super.isHighlighted = false
                UIView.animate(withDuration: 0.25, animations: {
                    self.voileView.alpha = 0.0
                })
            }
        }
    }
}
