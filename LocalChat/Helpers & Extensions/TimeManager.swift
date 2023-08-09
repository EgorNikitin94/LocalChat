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
}
