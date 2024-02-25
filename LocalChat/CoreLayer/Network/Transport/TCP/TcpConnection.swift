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
  weak var transport: TcpTransportInterface?
  private var socket: GCDAsyncSocket?
  private let tcpQueue: DispatchQueue = DispatchQueue(label: "com.localChat.tcpQueue")
  
  private let host = "localhost"
  private let port: UInt16 = 8080
  private let headerLength: UInt = 5
  
  private var inputTask: Task<(), Never>?
  
  private let logger = Log.custom(category: "Socket")
  
  private(set) lazy var outputSocketStream: AsyncThrowingStream<Data, Error> = {
    AsyncThrowingStream { (continuation: AsyncThrowingStream<Data, Error>.Continuation) -> Void in
      self.outputSocketContinuation = continuation
    }
  }()
  
  private var outputSocketContinuation: AsyncThrowingStream<Data, Error>.Continuation?
  
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
        self.logger.error("TCP socket create error: \(error.localizedDescription)")
      }
    }
  }
  
  func disconnect() {
    tcpQueue.async {
      self.socket?.disconnect()
      self.socket = nil
    }
  }
  
  private func startListenSocketInput() {
    guard let transport = self.transport else { return }
    inputTask = Task {
      for await sendedData in transport.inputSocketStream {
        let requestData = self.appendHeader(to: sendedData.data)
        self.socket?.write(requestData, withTimeout: -1, tag: Int(sendedData.id))
      }
    }
  }
  
  private func appendHeader(to data: Data) -> Data {
    var buf = Data(capacity: data.count + Int(self.headerLength))
    let header = Data(bytes: putUVarInt(UInt64(data.count)), count: Int(self.headerLength))
    buf.append(contentsOf: header + [UInt8](data))
    let requestData = Data(buf)
    return requestData
  }
}

extension TcpConnection: GCDAsyncSocketDelegate {
  func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
    logger.info("TCP didConnectToHost: \(host), port: \(port)")
    startListenSocketInput()
    transport?.socketDidSuccessConnect()
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
    logger.info("socketDidDisconnect: reason \(String(describing: err?.localizedDescription))")
    transport?.socketDidDisconnect()
  }
  
  func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
    //
  }
}
