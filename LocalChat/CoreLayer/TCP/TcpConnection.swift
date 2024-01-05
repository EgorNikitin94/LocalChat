//
//  TcpTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/26/22.
//

import Foundation
import CocoaAsyncSocket

final class TcpConnection: NSObject {
  private var socket: GCDAsyncSocket?
  private let tcpQueue: DispatchQueue = DispatchQueue(label: "com.localChat.tcpQueue")
  
  private let host = "localhost"
  private let port: UInt16 = 8080
  
  func connect() {
    tcpQueue.async {
      if self.socket != nil { return }
      self.socket = GCDAsyncSocket(delegate: self, delegateQueue: self.tcpQueue)
      
      do {
        try self.socket?.connect(toHost: self.host, onPort: self.port)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func disconnect() {
    tcpQueue.async {
      self.socket?.disconnect()
      self.socket = nil
    }
  }
}

extension TcpConnection: GCDAsyncSocketDelegate {
  func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
    print("TCP didConnectToHost: \(host), port: \(port)")
  }
}
