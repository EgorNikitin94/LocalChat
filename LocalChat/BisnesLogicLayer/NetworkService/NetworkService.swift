//
//  NetworkService.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class NetworkService: AbstractService {
  func performSysInitRequest() async throws -> Response {
    let request: NetworkRequest = await SysInitRequest()
    return try await performRequest(request)
  }
}
