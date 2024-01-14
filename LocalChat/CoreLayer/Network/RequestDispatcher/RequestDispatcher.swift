//
//  RequestDispatcher.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation
import DataStructures

enum RequestDispatcherError: Error {
  case canceledRequest
}

actor RequestDispatcher {
  private var pendingRequests: Queue<NetworkRequest> = Queue<NetworkRequest>()
  private var executingRequest: NetworkRequest?
  private let tcpTransport: TcpTransport
  
  init(tcpTransport: TcpTransport) {
    self.tcpTransport = tcpTransport
  }
  
  func didGet(data: Data) {
    do {
      let response = try Response(serializedData: data)
      if let netReq = dequeue(reqId: response.id) {
        netReq.responseContinuation?.yield(response)
        netReq.responseContinuation?.finish()
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func sendRequest(_ request: NetworkRequest) async throws -> Response {
    enqueue(req: request)
    
    for try await response in request.responseStream {
      return response
    }
    
    throw RequestDispatcherError.canceledRequest
  }
  
  private func next() {
    if executingRequest != nil {
      return
    }
    
    if let req = pendingRequests.front(), !pendingRequests.isEmpty {
      executingRequest = req
      tcpTransport.send(request: req.request)
    }
  }
  
  private func enqueue(req: NetworkRequest) {
    pendingRequests.enqueue(req)
    next()
  }
  
  private func dequeue(reqId: UInt32) -> NetworkRequest? {
    defer {
      next()
    }
    if let req = pendingRequests.dequeue(), req.id == reqId {
      executingRequest = nil
      return req
    }
    return nil
  }
}
