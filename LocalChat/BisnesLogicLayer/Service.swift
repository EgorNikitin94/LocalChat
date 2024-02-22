//
//  Service.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

protocol Service {
  var tag: ServiceTag { get }
  var requestDispatcher: RequestDispatcher { get }
}

extension Service {
  var requestDispatcher: RequestDispatcher {
    NetworkAssembly.shared.requestDispatcher
  }
  
  func performRequest(_ request: NetworkRequest) async throws -> NetworkResponse {
    try await requestDispatcher.sendRequest(request)
  }
}
