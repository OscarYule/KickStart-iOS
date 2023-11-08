//
//  Date+Extension.swift
//  YLDatePicker
//
//  Created by yl on 2017/11/15.
//  Copyright © 2017年 February12. All rights reserved.
//

import Foundation

//UIView+Extension

// MARK: - 时间转换
extension Date {
    func weekDay() -> String {

          let weekDays = [NSNull.init(),"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"] as [Any]
          let calendar = NSCalendar.init(calendarIdentifier: .gregorian)

          let timeZone = NSTimeZone.init(name: "Asia/Shanghai")

          calendar?.timeZone = timeZone as! TimeZone

          let calendarUnit = NSCalendar.Unit.weekday

          let theComponents = calendar?.components(calendarUnit, from: self)
          return weekDays[(theComponents?.weekday)!] as! String
      }
    
    static func getDate(dateStr: String, format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    func getComponent(component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    func getString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

}
