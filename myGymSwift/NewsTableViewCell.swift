//
//  NewsTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 07/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLeftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var bodyLeftMarginConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true*/
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        /*if selected{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundSelection)
        }
        else{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundDefault)
        }*/
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundSelection)
        }
        else{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundDefault)
        }
    }
    
    func setData(news: NewsModel) {
        
        titleLabel?.text      = "Bonne année"//news.title
        titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)

        bodyLabel?.text      = news._description
        bodyLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)

        dayLabel?.text         = FormaterManager.SharedInstance.formatMMddFromDate(news.day)
        dayLabel?.textColor    = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
        
        titleLeftMarginConstraint.constant = 82
        bodyLeftMarginConstraint .constant = 82

    }
    
    func setDataV2(news: NewsModel) {
      
        titleLabel?.text      = "Bienvenue à notre nouveau coach"  //news.title
        dayLabel?.text         = FormaterManager.SharedInstance.formatMMddFromDate(news.day)
        //titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        
        /*bodyLabel?.text      = news._description
        bodyLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)
        
        dayLabel?.text         = FormaterManager.SharedInstance.formatMMddFromDate(news.day)
        dayLabel?.textColor    = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
        
        titleLeftMarginConstraint.constant = 82
        bodyLeftMarginConstraint .constant = 82*/
        
    }
}
