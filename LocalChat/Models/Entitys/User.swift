//
//  User.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import UIKit
import GRDB

enum UserType: Codable {
  case selfUser
  case anotherUser
}

struct User: Peer {
  var id: UUID = UUID()
  var type: PeerType = .user
  let userType: UserType
  let name: String
  let phone: String
  let avatarTitle: String?
  var isOnline: Bool
  
  var title: String {
    name
  }
  
  var isMe: Bool {
    return userType == .selfUser
  }
  
  var avatar: UIImage? {
    guard let imageName = avatarTitle else {
      return nil
    }
    return UIImage(named: imageName)
  }
}

extension User: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension User {
  enum Columns: String, ColumnExpression {
    case id, type, userType, name, phone, avatarTitle, isOnline
  }
  
  static let databaseTableName: String = "user"
}
