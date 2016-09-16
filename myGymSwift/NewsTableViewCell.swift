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
    @IBOutlet weak var newsImage: UIImageView!

    //@IBOutlet weak var titleLeftMarginConstraint: NSLayoutConstraint!
    //@IBOutlet weak var bodyLeftMarginConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
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
        /*if highlighted{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundSelection)
        }
        else{
            backgroundColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellBackgroundDefault)
        }*/
    }
    
    func setData(feed: FBFeedModel) {
        
        dayLabel?.text   = FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(feed.created_time!))

        if (feed.message != nil)
        {
            titleLabel?.text  = feed.message
        }
        else if (feed.actions != nil)
        {
            titleLabel?.text  = "WinFintess a partagé :"
        }
        else if (feed.type != nil)
        {
            titleLabel?.text  = "WinFintess a ajouté :"
        }
        
        if (feed._description != nil)
        {
            bodyLabel?.text  = feed._description
        }
      
        bodyLabel?.textColor  = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)
        titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        dayLabel?.textColor   = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
        
        //titleLeftMarginConstraint.constant = 82
        //bodyLeftMarginConstraint .constant = 82

    }
}
