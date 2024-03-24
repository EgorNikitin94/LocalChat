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

struct User: Peer, Hashable {
  var id: UUID = UUID()
  var type: PeerType = .user
  let userType: UserType
  let name: String
  let phone: String
  let avatarTitle: String?
  var isOnline: Bool
  
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

extension User {
  enum Columns: String, ColumnExpression {
    case id, type, userType, name, phone, avatarTitle, isOnline
  }
  
  static var databaseTableName: String = "user"
}
