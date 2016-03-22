//
//  FormaterManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 05/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class FormaterManager: NSObject {

    static let SharedInstance = FormaterManager()
    let yyyyMMdd = "yyyy-MM-dd"
    let formatServerDate = "yyyy-MM-dd'T'HH:mm:ss'.'SSSZ"
    let EEEE_dd = "EEEE dd"
    let dd_MM = "dd/MM"

    let MMM = "MMM"

    let fr_BI   = "fr_BI"
    let diez    = "#"

    // MARK: - Dates

    func formatyyyMMddFromString(dateString: String) -> NSDate {

        let formatter = NSDateFormatter()
        formatter.dateFormat = yyyyMMdd
        //formatter.timeZone = NSTimeZone(abbreviation: "UTC")

        let dateFromString: NSDate = formatter.dateFromString(dateString)!
        
        return dateFromString
    }
    
    func formatServerDateFromString(dateString: String) -> NSDate {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatServerDate
        //formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let dateFromString: NSDate = formatter.dateFromString(dateString)!
        
        return dateFromString
    }
    
    func formatMMddFromDate(dateDate: NSDate) -> String {

        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dd_MM
        dateFormatter.locale = NSLocale.init(localeIdentifier: fr_BI)

        let stringFromDate = dateFormatter.stringFromDate(dateDate)
        
        return stringFromDate
    }
    
    func formatWeekDayAndDate(aDate: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = EEEE_dd
        dateFormatter.locale = NSLocale.init(localeIdentifier: fr_BI)
        let newDay =  dateFormatter.stringFromDate(aDate).capitalizedString
        
        return newDay
    }

    
    func isSameDayWithDate1(date1: NSDate, date2: NSDate) -> Bool {
        
        let cal = NSCalendar.currentCalendar()
        var components = cal.components([.Era, .Year, .Month, .Day], fromDate: date1)
        let today = cal.dateFromComponents(components)!
        
        components = cal.components([.Era, .Year, .Month, .Day], fromDate:date2);
        let otherDate = cal.dateFromComponents(components)!
        
        if(today.isEqualToDate(otherDate)) {
            return true
        }
        return false
    }
    
    // MARK: - Colors

    func uicolorFromHexa(hexString:String) -> UIColor {
        
        let hexString:String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner = NSScanner(string: hexString)
        
        if (hexString.hasPrefix(diez)) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
