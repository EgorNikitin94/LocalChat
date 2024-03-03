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
    try super.handleResponse(protoResponse: protoResponse)
    guard
      let payload = protoResponse.payload,
      case let Response.OneOf_Payload.pong(pong) = payload
    else {
      throw NetworkResponseError.notExpectedRequest
    }
    return .pong(id: pong.id)
  }
}
