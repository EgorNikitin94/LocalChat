//
//  TcpTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/26/22.
//

import Foundation
import CocoaAsyncSocket
import VarInt

final class TcpConnection: NSObject {
  private var socket: GCDAsyncSocket?
  private let tcpQueue: DispatchQueue = DispatchQueue(label: "com.localChat.tcpQueue")
  
  private let host = "localhost"
  private let port: UInt16 = 8080
  
  private let headerLength: UInt = 5
  
  private(set) lazy var outputSocketStream: AsyncThrowingStream<Data, Error> = {
    AsyncThrowingStream { (continuation: AsyncThrowingStream<Data, Error>.Continuation) -> Void in
      self.outputSocketContinuation = continuation
    }
  }()
  
  private(set) var outputSocketContinuation: AsyncThrowingStream<Data, Error>.Continuation?
  
  enum PacketType: Int {
    case header
    case body
  }
  
  func connect() {
    tcpQueue.async {
      if self.socket != nil { return }
      self.socket = GCDAsyncSocket(delegate: self, delegateQueue: self.tcpQueue)
      
      do {
        try self.socket?.connect(toHost: self.host, onPort: self.port)
        self.socket?.readData(toLength: self.headerLength, withTimeout: -1, tag: PacketType.header.rawValue)
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
      let requestData = self.appendHeader(to: data)
      self.socket?.write(requestData, withTimeout: -1, tag: Int(id))
    }
  }
  
  private func appendHeader(to data: Data) -> Data {
    var buf = Data(capacity: data.count + Int(self.headerLength))
    let header = Data(bytes: putUVarInt(UInt64(data.count)), count: Int(self.headerLength))
    buf.append(contentsOf: header + [UInt8](data))
    let requestData = Data(buf)
    return requestData
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
    if tag == PacketType.header.rawValue {
      let array = [UInt8](data)
      let bodySize: UInt64 = uVarInt(array).value
      if bodySize > 0 {
        self.socket?.readData(toLength: UInt(bodySize), withTimeout: -1, tag: PacketType.body.rawValue)
      } else {
        self.socket?.readData(toLength: self.headerLength, withTimeout: -1, tag: PacketType.header.rawValue)
      }
    } else if tag == PacketType.body.rawValue {
      outputSocketContinuation?.yield(with: .success(data))
      self.socket?.readData(toLength: self.headerLength, withTimeout: -1, tag: PacketType.header.rawValue)
    }
  }
  
  func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
    print("socketDidDisconnect: reason \(String(describing: err?.localizedDescription))")
  }
  
  func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
    //
  }
}
