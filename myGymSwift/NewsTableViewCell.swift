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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsetsZero
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
    
    func setData(feed: FBFeedModel)
    {
        dayLabel?.text   = FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(feed.created_time!))
        titleLabel?.text = feedTitle(feed)
        bodyLabel?.text  = feedBody(feed)

        bodyLabel?.textColor  = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)
        titleLabel?.textColor = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.selectionTabBarColor)
        dayLabel?.textColor   = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
    }
    
    func feedTitle(feed: FBFeedModel)->String
    {
        if (feed.message != nil)
        {
            return feed.message!
        }
        
        if (feed.actions != nil)
        {
            let dict = feed.actions![0] as NSDictionary
            if (dict[ModelsConstants.kName] as! String == ModelsConstants.kShare)
            {
                return NSLocalizedString("WINFITNESS_HAS_SHARED", comment:"")
            }
            
            return NSLocalizedString("WINFITNESS_HAS_ADDED", comment:"")
        }
        
        if (feed.type != nil)
        {
            if(feed.type == ModelsConstants.kPhoto)
            {
                return NSLocalizedString("WINFITNESS_HAS_ADDED_PHOTO", comment:"")
            }
            return NSLocalizedString("WINFITNESS_HAS_ADDED", comment:"")
        }
        
        return ""
    }
    
    func feedBody(feed: FBFeedModel)->String
    {
        if (feed._description != nil)
        {
            return feed._description!
        }
        return ""
    }
}