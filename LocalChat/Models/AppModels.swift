//
//  AppModels.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import UIKit

enum UserType {
  case selfUser
  case anotherUser
}

struct User {
  let type: UserType
  let name: String
  let passsword: String
  let avatar: UIImage?
  var isOnline: Bool
  
  var isCurrentUser: Bool {
    return type == .selfUser
  }
}

struct Dialog: Identifiable, Hashable {
  static func == (lhs: Dialog, rhs: Dialog) -> Bool {
    return lhs.id.uuidString == rhs.id.uuidString
  }
  func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
  
  let id: UUID = UUID()
  let user: User
  let lastMessage: Message?
  var unreadCount: Int = 0
  
  var lastMessageDate: String? {
    guard let lastMessageDate = lastMessage?.date else { return nil }
    let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    let monthDay = "d MMM";
    
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

struct Message: Identifiable {
  let id: UUID = UUID()
  let from: User
  let to: User
  let date: Date
  let text: String
}
