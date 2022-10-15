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

struct Dialog {
  let id: UUID = UUID()
  let user: User
  let lastMessage: Message?
  var unreadCount: Int = 0
}

struct Message: Identifiable {
  let id: UUID = UUID()
  let from: User
  let to: User
  let date: Date
  let text: String
}
