//
//  SysInitRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

class SysInitRequest: TCPRequest {
  override var priority: RequestPriority {
    .sysInit
  }
  
  convenience init(sessionId: String) async {
    await self.init()
    self.request.payload = .sysInit(SysInit.with({
      $0.appID = "37FF7DA9-42F4-4213-B6ED-4CF2A22A958A"
      $0.appSecret = "9FB828F0-E522-47FD-A5DF-3E05791E6AA5"
      $0.sessionID = sessionId
    }))
  }
  
  override func handleResponse(protoResponse: Response) throws -> NetworkResponse {
    guard
      !protoResponse.sysInited.sessionID.isEmpty && protoResponse.sysInited.pts != 0
    else {
      throw NetworkResponseError.notExpectedRequest
    }
    let sessionId = protoResponse.sysInited.sessionID
    let pts = protoResponse.sysInited.pts
    return .sysInited(sessionId: sessionId, pts: pts)
  }
}
