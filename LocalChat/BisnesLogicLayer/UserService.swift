//
//  UserService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import UIKit

protocol UserServiceProtocol {
  var currentUser: User {get}
  
  func getUser(with id: String) -> User
  
  func getAllUsers() -> [User]
}

class UserService {
  
}

class MockUserService: UserServiceProtocol {
  var currentUser: User = User(type: .selfUser, name: "Egor", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
  
  private var users: [User] = [User(type: .anotherUser, name: "John Poster", passsword: "1123", avatar: UIImage(named: "mock_1"), isOnline: true),
                               User(type: .anotherUser, name: "Bob Robins", passsword: "1123", avatar: nil, isOnline: false),
                               User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false),
                               User(type: .anotherUser, name: "Rob Stark", passsword: "1123", avatar: UIImage(named: "mock_3"), isOnline: true),
                               User(type: .anotherUser, name: "Jim Bim", passsword: "1123", avatar: nil, isOnline: false),
                               User(type: .anotherUser, name: "Antony Blinkin", passsword: "1123", avatar: nil, isOnline: true),
                               User(type: .anotherUser, name: "Vladimir Rezanov", passsword: "1123", avatar: nil, isOnline: true)
  ]
  
  func getUser(with id: String) -> User {
    return users.first!
  }
  
  func getAllUsers() -> [User] {
    return users
  }
}
