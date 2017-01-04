//
//  ContactsTableViewCell.swift
//  myGymSwift
//
//  Created by SQLI51109 on 04/01/2017.
//  Copyright © 2017 julien gimenez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var titreClubLabel: UILabel!
    @IBOutlet weak var titreArrondissementLabel: UILabel!
    @IBOutlet weak var titreRenseignementsLabel: UILabel!
    @IBOutlet weak var adresseButton: UIButton!
    @IBOutlet weak var titreHorairesLabel: UILabel!
    @IBOutlet weak var titreEntrainementsLabel: UILabel!
    @IBOutlet weak var renseignementsTextView: UITextView!
    @IBOutlet weak var entrainementsTextView: UITextView!

    var clubContact: ContactModel = ContactModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ contact: ContactModel) {
        
        clubContact = contact
        titreClubLabel.text = contact.club
        titreArrondissementLabel.text = contact.district
        titreRenseignementsLabel.text = NSLocalizedString("INORMATIONS", comment:"")
        adresseButton.setTitle(contact.address, for: .normal)
        titreHorairesLabel.text = NSLocalizedString("SCHEDULE", comment:"")
        titreEntrainementsLabel.text = NSLocalizedString("TRAININGS", comment:"")
        renseignementsTextView.text = contact.informations
        entrainementsTextView.text = contact.trainings
    }
    
    @IBAction func openMap(sender: AnyObject) {
        
        let lat1 : NSString = clubContact.latitude as NSString
        let lng1 : NSString = clubContact.longitude as NSString
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = clubContact.club + " " + clubContact.district
        mapItem.openInMaps(launchOptions: options)
    }
}
