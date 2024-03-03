//
//  NetworkService.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class NetworkService: Service {
  let tag: ServiceTag = .network
  
  @UserDefaultsStored(key: "session_pts", defaultValue: 0)
  private(set) var pts: UInt32
  @UserDefaultsStored(key: "session_id", defaultValue: "")
  private(set) var sessionId: String
  
  func performSysInitRequest() async throws -> (sessionId: String, pts: UInt32) {
    let request: NetworkRequest = await SysInitRequest(sessionId: sessionId)
    let response = try await performRequest(request)
    guard case let NetworkResponse.sysInited(sessionId: sessionId, pts: pts) = response else {
      throw NetworkResponseError.notExpectedRequest
    }
    self.pts = pts
    self.sessionId = sessionId
    return (sessionId, pts)
  }
  
  func performPingRequest() async throws -> Bool {
    let request: NetworkRequest = await PingRequest()
    let response =  try await performRequest(request)
    guard case let NetworkResponse.pong(id) = response else {
      throw NetworkResponseError.notExpectedRequest
    }
    return id > 0
  }
}
