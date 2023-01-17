//
//  DateExtension.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import Foundation

extension String {
    func dates() -> String {
        let date = Date()
        let calender = Calendar.current
        let day = calender.component(.day, from: date)
        let month = calender.component(.month, from: date)
        let year = calender.component(.year, from: date)
        let hour = calender.component(.hour, from: date)
        let minute = calender.component(.minute, from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)

//        let time = "\(hour):\(minute)"
        
        let dates = "\(month)/\(day)/\(year)"
        return dates
    }
    
    func today() -> String {
        let date = Date()
        let calender = Calendar.current
        let day = calender.component(.day, from: date)
        let month = calender.component(.month, from: date)
        let year = calender.component(.year, from: date)
        let hour = calender.component(.hour, from: date)
        let minute = calender.component(.minute, from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)

//        let time = "\(hour):\(minute)"
        
        let today = "\(dayInWeek)"
        return today
    }
    
    func week() -> String {
        let date = Date()
        let calender = Calendar.current
        let today = calender.startOfDay(for: Date())
        let day = calender.component(.day, from: date)
        let month = calender.component(.month, from: date)
        let year = calender.component(.year, from: date)
        let hour = calender.component(.hour, from: date)
        let minute = calender.component(.minute, from: date)
        let week = calender.component(.weekOfMonth, from: date)
        let weekdays = calender.component(.weekday, from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)

//        let time = "\(hour):\(minute)"
        
        let weeks = "\(weekdays)"
        return weeks
    }
    
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    
}
