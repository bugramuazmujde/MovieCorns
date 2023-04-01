//
//  CalculateTimeDifference.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation


func calculateTimeDifference(from dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    
    guard let postDate = dateFormatter.date(from: dateString) else {
        return nil
    }
    
    let now = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: postDate, to: now)
    
    if let years = components.year, years >= 1 {
        return "\(years) years later"
    } else if let months = components.month, months >= 1 {
        return "\(months) mounts later"
    } else if let weeks = components.weekOfYear, weeks >= 1 {
        return "\(weeks) weeks later"
    } else if let days = components.day, days >= 1 {
        return "\(days) days later"
    } else if let hours = components.hour, hours >= 1 {
        return "\(hours) hours later"
    } else if let minutes = components.minute, minutes >= 1 {
        return "\(minutes) minutes later"
    } else {
        return "Now"
    }
}
