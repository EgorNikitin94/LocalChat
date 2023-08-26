//
//  TimeMenager.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/15/22.
//

import Foundation

struct TimeManagerHalper {
  static func makeString(from date: Date?) -> String? {
    guard let lastMessageDate = date else { return nil }
    let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    let monthDay = "d MMM"
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    
    let now = gregorian.dateComponents([.year, .month, .day], from: Date())
    let d = gregorian.dateComponents([.year, .month, .day], from: lastMessageDate)
    
    if now.year == d.year && now.month == d.month && now.day == d.day {
  //    formatter.dateFormat = @"h:mma";
      dateFormatter.dateStyle = .none
      dateFormatter.timeStyle = .short
      //    return NSLocalizedString(@"today", nil);
    } else if now.year == d.year {
      dateFormatter.dateFormat = monthDay;
    } else {
      dateFormatter.dateFormat = "d MMM, YYYY"
    }
    
    return dateFormatter.string(from: lastMessageDate)
  }
  
  static func messageTime(from date: Date?) -> String? {
    guard let messageDate = date else { return nil }
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: messageDate)
  }
  
  static func messageTimeCapsuleTime(from date: Date?) -> String? {
    guard let messageDate = date else { return nil }
    let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    
    let now = gregorian.dateComponents([.year, .month, .day], from: Date())
    let d = gregorian.dateComponents([.year, .month, .day], from: messageDate)
    
    if gregorian.isDateInToday(messageDate) {
      return "today"
    } else if d.day! >= now.day! - 7 {
      if gregorian.isDateInYesterday(messageDate) {
        return "yesterday"
      } else {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: messageDate)
      }
    }
    
    dateFormatter.dateFormat = "MMM d"
    return dateFormatter.string(from: messageDate)
  }
}
