//
//  ContactManager.swift
//  myGymSwift
//
//  Created by SQLI51109 on 04/01/2017.
//  Copyright © 2017 julien gimenez. All rights reserved.
//

import Foundation

class ContactsManager: NSObject {
    
    func getContacts(_ completion: @escaping (_ contactsArray: Array<ContactModel>) -> Void){
        
        self.getContactsfromDB({ (contactsFromDB) -> Void in
            completion(contactsFromDB)
        })
    }
    
    func getContactsfromDB(_ completion: @escaping (_ sportsArray: Array<ContactModel>) -> Void){
        
        RealmManager.SharedInstance.getAllContactsFromDB { (contacts) -> Void in
            completion(contacts)
        }
    }
}
