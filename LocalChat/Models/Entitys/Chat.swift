//
//  Chat.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/23/24.
//

import UIKit
import GRDB

struct Chat: Peer {
  let id: UUID
  var type: PeerType = .chat
  let title: String
  let avatarTitle: String?
  
  var avatar: UIImage? {
    guard let imageName = avatarTitle else {
      return nil
    }
    return UIImage(named: imageName)
  }
}

extension Chat: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Chat {
  enum Columns: String, ColumnExpression {
    case id, type
  }
  
  
  static let databaseTableName: String = "chat"
}
