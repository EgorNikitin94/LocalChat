//
//  User.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import UIKit

enum UserType: Codable {
  case selfUser
  case anotherUser
}

struct User: Peer, Hashable {
  let id: String = UUID().uuidString
  let type: PeerType = .user
  let userType: UserType
  let name: String
  let phone: String
  let avatar: UIImage?
  var isOnline: Bool
  
  var isMe: Bool {
    return userType == .selfUser
  }
}
