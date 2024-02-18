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
  
  override init() async {
    await super.init()
    
    self.request.payload = .sysInit(SysInit.with({
      $0.appID = "df"
      $0.appSecret = "sd"
      $0.seeesionID = "3232"
    }))
  }
  
  override func handleResponse(protoResponse: Response) throws -> NetworkResponse {
    guard 
      !protoResponse.sysInited.seeesionID.isEmpty && protoResponse.sysInited.pts != 0
    else {
      throw NetworkResponseError.notExpectedRequest
    }
    let sessionId = protoResponse.sysInited.seeesionID
    let pts = protoResponse.sysInited.pts
    return .sysInited(sessionId: sessionId, pts: pts)
  }
}
