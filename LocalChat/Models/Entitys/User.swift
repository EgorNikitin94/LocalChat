//
//  User.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import UIKit

enum UserType {
  case selfUser
  case anotherUser
}

struct User: Hashable {
  let type: UserType
  let name: String
  let passsword: String
  let avatar: UIImage?
  var isOnline: Bool
  
  var isCurrentUser: Bool {
    return type == .selfUser
  }
}
