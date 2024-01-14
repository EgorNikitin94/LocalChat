//
//  RequestDispatcher.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation
import DataStructures

actor RequestDispatcher {
  private var pendingRequests: Queue<NetworkRequest> = Queue<NetworkRequest>()
  private var executingRequest: NetworkRequest?
  private let tcpTransport: TcpTransport = TcpTransport()
  
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
  
  func perform(request: NetworkRequest) async throws -> Response? {
    var request: NetworkRequest = await TCPRequest()
    request.request.payload = .sysInit(SysInit.with({
      $0.appID = "df"
      $0.appSecret = "sd"
      $0.seeesionID = "3232"
    }))
    enqueue(req: request)
    
    for try await response in request.responseStream {
      return response
    }
    
    return nil
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
