//
//  NewsTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 07/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        super.setHighlighted(highlighted, animated: animated)
    }
    
    func setData(_ feed: FBFeedModel)
    {
        dayLabel?.text   = FormaterManager.SharedInstance.formatMMddFromDate(FormaterManager.SharedInstance.formatServerDateFromString(feed.created_time!))
        bodyTextView?.text  = feed.feedBody()
        bodyTextView?.textColor  = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.bodyNewsCellText)
        dayLabel?.textColor   = FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.dayNewsCell)
    }
}
