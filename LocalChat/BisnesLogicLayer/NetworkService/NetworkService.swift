//
//  NetworkService.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class NetworkService: AbstractService {
  var pts: UInt32 = 0
  var sessionId: String = ""
  
  func performSysInitRequest() async throws -> (sessionId: String, pts: UInt32) {
    let request: NetworkRequest = await SysInitRequest()
    let response = try await performRequest(request)
    guard case let NetworkResponse.sysInited(sessionId: sessionId, pts: pts) = response  else {
      throw NetworkResponseError.notExpectedRequest
    }
    self.pts = pts
    self.sessionId = sessionId
    return (sessionId, pts)
  }
}
