//
//  ServicesCatalog.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/22/24.
//

import Foundation

enum ServiceTag {
  case network
  case auth
  case user
  case message
  case dialog
}

final class ServicesCatalog {
  static let shared: ServicesCatalog = ServicesCatalog()
  
  private lazy var services: [ServiceTag: Service] = [:]
  
  var authService: AuthServiceProtocol {
    resolve(tag: .auth) as! AuthServiceProtocol
  }
  
  var networkService: NetworkService {
    resolve(tag: .network) as! NetworkService
  }
  
  private init() {}
  
  func initalSetup() {
    register(service: NetworkService())
    register(service: AuthService())
  }
  
  func register(service: Service) {
    guard services.keys.contains(where: { $0 == service.tag }) else { return }
    services[service.tag] = service
  }
  
  func resolve(tag: ServiceTag) -> Service? {
    services[tag]
  }
  
  func unregester(tag: ServiceTag) {
    services[tag] = nil
  }
}
