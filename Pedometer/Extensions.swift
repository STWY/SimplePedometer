//
//  Extensions.swift
//  SimplePedometer
//
//  Created by STWY on 16/5/22.
//  Copyright © 2016年 STWY. All rights reserved.
//

import Foundation

extension NSDate {
    class var midnight: NSDate {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let components: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        return calendar.dateFromComponents(calendar.components(components, fromDate: NSDate()))!
    }
}
