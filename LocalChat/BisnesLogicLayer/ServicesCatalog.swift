//
//  ServicesCatalog.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/22/24.
//

import Foundation

protocol Service {
  typealias ServiceTag = String
  var tag: ServiceTag { get }
}

final class ServicesCatalog {
  static let shared: ServicesCatalog = ServicesCatalog()
  
  private var services: [Service.ServiceTag: Service] = [:]
//  let authService: AuthServiceProtocol
  
  private init() {}
  
  func initalSetup() {
    //
  }
}
