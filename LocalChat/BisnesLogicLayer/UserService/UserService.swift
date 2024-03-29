//
//  UserService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import UIKit

protocol UserServiceProtocol: Service {
  var currentUser: User { get }
  
  func getUser(with id: String) -> User
  
  func getAllUsers() -> [User]
}

class UserService {
  
}

class MockUserService: UserServiceProtocol {
  let tag: ServiceTag = .user
  
  var currentUser: User = User(userType: .selfUser, name: "Egor", phone: "8(999)999-99-99", avatarTitle: "Me", isOnline: true)
  
  private var users: [User] = [User(userType: .anotherUser, name: "John Poster", phone: "8(999)999-99-90", avatarTitle: "mock_1", isOnline: true),
                               User(userType: .anotherUser, name: "Bob Robins", phone: "8(999)999-99-91", avatarTitle: nil, isOnline: false),
                               User(userType: .anotherUser, name: "Sarra Bold", phone: "8(999)999-99-92", avatarTitle: "mock_2", isOnline: false),
                               User(userType: .anotherUser, name: "Rob Stark", phone: "8(999)999-99-93", avatarTitle: "mock_3", isOnline: true),
                               User(userType: .anotherUser, name: "Jim Bim", phone: "8(999)999-99-94", avatarTitle: nil, isOnline: false),
                               User(userType: .anotherUser, name: "Antony Blinkin", phone: "8(999)999-99-95", avatarTitle: nil, isOnline: true),
                               User(userType: .anotherUser, name: "Vladimir Rezanov", phone: "8(999)999-99-96", avatarTitle: nil, isOnline: true)
  ]
  
  func getUser(with id: String) -> User {
    return users.first!
  }
  
  func getAllUsers() -> [User] {
    return users
  }
}
