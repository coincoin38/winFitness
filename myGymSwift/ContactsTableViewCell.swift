//
//  ContactsTableViewCell.swift
//  myGymSwift
//
//  Created by SQLI51109 on 04/01/2017.
//  Copyright © 2017 julien gimenez. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var titreClubLabel: UILabel!
    @IBOutlet weak var titreArrondissementLabel: UILabel!
    @IBOutlet weak var titreRenseignementsLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var titreHorairesLabel: UILabel!
    @IBOutlet weak var titreEntrainementsLabel: UILabel!
    @IBOutlet weak var renseignementsTextView: UITextView!
    @IBOutlet weak var entrainementsTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
