//
//  Service.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class AbstractService {
  var requestDispatcher: RequestDispatcher
  
  init() {
    self.requestDispatcher = NetworkAssembly.shared.requestDispatcher
  }
  
  func performRequest(_ request: NetworkRequest) async throws -> NetworkResponse {
    try await requestDispatcher.sendRequest(request)
  }
}
