//
//  PingRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/3/24.
//

import Foundation

class PingRequest: TCPRequest {
  override var priority: RequestPriority {
    .high
  }
  
  override init() async {
    await super.init()
    self.request.payload = .ping(Ping.with({
      $0.id = self.id
    }))
  }
  
  override func handleResponse(protoResponse: Response) throws -> NetworkResponse {
    guard
      protoResponse.pong.id != UInt32(0)
    else {
      throw NetworkResponseError.notExpectedRequest
    }
    return .pong(id: protoResponse.pong.id)
  }
}
