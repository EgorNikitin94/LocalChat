//
//  TCPRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

class TCPRequest: NetworkRequest, @unchecked Sendable {
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
  
  @discardableResult
  func handleResponse(protoResponse: Response) throws -> NetworkResponse {
    try handleError(protoResponse: protoResponse)
  }
  
  private func handleError(protoResponse: Response) throws -> NetworkResponse {
    switch protoResponse.payload {
    case .error(let error):
      throw NetworkResponseError.error(NetworkError(with: error))
    default: .unknown
    }
  }
}
