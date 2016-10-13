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
    let formatServerDate = "yyyy-MM-dd'T'HH:mm:ss'+'0000"
    let EEEE_dd = "EEEE dd"
    let dd_MM = "dd MMMM, HH:mm"

    let MMM = "MMM"

    let fr_BI   = "fr_BI"
    let diez    = "#"

    // MARK: - Dates

    func formatyyyMMddFromString(_ dateString: String) -> Date {

        let formatter = DateFormatter()
        formatter.dateFormat = yyyyMMdd
        //formatter.timeZone = NSTimeZone(abbreviation: "UTC")

        let dateFromString: Date = formatter.date(from: dateString)!
        
        return dateFromString
    }
    
    func formatServerDateFromString(_ dateString: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = formatServerDate
        //formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let dateFromString: Date = formatter.date(from: dateString)!
        
        return dateFromString
    }
    
    func formatMMddFromDate(_ dateDate: Date) -> String {

        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dd_MM
        dateFormatter.locale = Locale.init(identifier: fr_BI)

        let stringFromDate = dateFormatter.string(from: dateDate)
        
        return stringFromDate
    }
    
    func formatWeekDayAndDate(_ aDate: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = EEEE_dd
        dateFormatter.locale = Locale.init(identifier: fr_BI)
        let newDay =  dateFormatter.string(from: aDate).capitalized
        
        return newDay
    }

    
    func isSameDayWithDate1(_ date1: Date, date2: Date) -> Bool {
        
        let cal = Calendar.current
        var components = (cal as NSCalendar).components([.era, .year, .month, .day], from: date1)
        let today = cal.date(from: components)!
        
        components = (cal as NSCalendar).components([.era, .year, .month, .day], from:date2);
        let otherDate = cal.date(from: components)!
        
        if(today == otherDate) {
            return true
        }
        return false
    }
    
    // MARK: - Colors

    func uicolorFromHexa(_ hexString:String) -> UIColor {
        
        let hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix(diez)) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func getDayOfWeek()->Int? {
        
        let date = Date()
        let calendar = Calendar.current
        
        return calendar.component(.weekday, from: date)
    }
}
