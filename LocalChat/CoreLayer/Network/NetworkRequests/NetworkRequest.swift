//
//  NetworkRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

enum RequestPriority {
  case background
  case standart
  case action
  case high
  case missingUpdates
  case sysInit
}

protocol NetworkRequest {
  var id: UInt32 { get }
  var priority: RequestPriority { get }
  var request: Request { get set }
  var responseStream: AsyncThrowingStream<Response, Error> { get }
  var responseContinuation: AsyncThrowingStream<Response, Error>.Continuation? { get }
  
  func handleResponse(protoResponse: Response) throws -> NetworkResponse
}
