//
//  AutorisationService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import Foundation

protocol AuthServiceProtocol: Service {
  func checkLogin(_ loginStr: String) async throws -> Bool
  func sighIn(login: String, password: String) async throws -> User
  func sighUp(email: String, name: String) async throws -> User
}

class AuthService: AuthServiceProtocol {
  let tag: ServiceTag = .auth
  
  func checkLogin(_ loginStr: String) async throws -> Bool {
    true
  }
  
  func sighIn(login: String, password: String) async throws -> User {
    User(userType: .selfUser, name: "Egor", phone: "qwerty", avatarTitle: nil, isOnline: true)
  }
  
  func sighUp(email: String, name: String) async throws -> User {
    User(userType: .selfUser, name: "Egor", phone: "qwerty", avatarTitle: nil, isOnline: true)
  }
  
  
}

class MockAuthService: AuthServiceProtocol {
  let tag: ServiceTag = .auth
  
  func checkLogin(_ loginStr: String) async throws -> Bool {
    true
  }
  
  func sighIn(login: String, password: String) async throws -> User {
    User(userType: .selfUser, name: "Egor", phone: "qwerty", avatarTitle: nil, isOnline: true)
  }
  
  func sighUp(email: String, name: String) async throws -> User {
    User(userType: .selfUser, name: "Egor", phone: "qwerty", avatarTitle: nil, isOnline: true)
  }
}
