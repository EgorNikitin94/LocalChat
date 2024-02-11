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
  
  private(set) lazy var outputSocketStream: AsyncThrowingStream<Data, Error> = {
    AsyncThrowingStream { (continuation: AsyncThrowingStream<Data, Error>.Continuation) -> Void in
      self.outputSocketContinuation = continuation
    }
  }()
  
  private(set) var outputSocketContinuation: AsyncThrowingStream<Data, Error>.Continuation?
  
  func connect() {
    tcpQueue.async {
      if self.socket != nil { return }
      self.socket = GCDAsyncSocket(delegate: self, delegateQueue: self.tcpQueue)
      
      do {
        try self.socket?.connect(toHost: self.host, onPort: self.port)
//        self.socket?.startTLS(nil)
//        self.socket?.readData(toLength: 5, withTimeout: -1, tag: 1)
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
  
  func send(data: Data, id: UInt32) {
    tcpQueue.async {
      self.socket?.write(data, withTimeout: -1, tag: Int(id))
    }
  }
  
  private func lendHand() {
    Task {
      do {
        let _ = try await NetworkAssembly.shared.networkService.performSysInitRequest()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension TcpConnection: GCDAsyncSocketDelegate {
  func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
    print("TCP didConnectToHost: \(host), port: \(port)")
    lendHand()
  }
  
  func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
    outputSocketContinuation?.yield(with: .success(data))
  }
  
  func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
    print("socketDidDisconnect: reason \(String(describing: err?.localizedDescription))")
  }
  
  func socketDidSecure(_ sock: GCDAsyncSocket) {
    print("socketDidSecure:")
    //lendHand()
  }
  
  func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
    //
  }
}
