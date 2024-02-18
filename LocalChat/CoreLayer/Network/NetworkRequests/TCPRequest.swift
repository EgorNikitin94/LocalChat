//
//  TCPRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

class TCPRequest: NetworkRequest {
  let id: UInt32
  var request: Request
  var priority: RequestPriority {
    .standart
  }
  
  private(set) lazy var responseStream: AsyncThrowingStream<Response, Error> = {
    AsyncThrowingStream { (continuation: AsyncThrowingStream<Response, Error>.Continuation) -> Void in
      self.responseContinuation = continuation
    }
  }()
  
  private(set) var responseContinuation: AsyncThrowingStream<Response, Error>.Continuation?
  
  init() async {
    self.id = await RequestIdCounter.shared.requestId
    var request = Request()
    request.id = self.id
    self.request = request
  }
  
  func handleResponse(protoResponse: Response) throws -> NetworkResponse {
    throw NetworkResponseError.notImplementedInSubclass
  }
}
