//
//  TcpTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/26/22.
//

import Foundation
@preconcurrency import CocoaAsyncSocket
import VarInt
import NIO

final class TcpConnection: NSObject, @unchecked Sendable {
  weak var transport: TcpTransportInterface?
  private var socket: GCDAsyncSocket?
  private let tcpQueue: DispatchQueue = DispatchQueue(label: "com.localChat.tcpQueue")
  
  private let host = "localhost"
  private let port: Int = 8080
  private let headerLength: UInt = 5
  
  private var inputTask: Task<(), Never>?
  
  private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
  
  private var outbound: NIOAsyncChannelOutboundWriter<ByteBuffer>? = nil
  private var clientChannel: NIOAsyncChannel<ByteBuffer, ByteBuffer>? = nil
  
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
    Task {
      do {
        self.clientChannel = try await ClientBootstrap(group: group)
          .connect(
            host: host,
            port: port
          ) { channel in
            return channel.eventLoop.makeCompletedFuture {
              return try NIOAsyncChannel<ByteBuffer, ByteBuffer>(
                wrappingChannelSynchronously: channel
              )
            }
          }
        
        try await self.clientChannel?.executeThenClose { inbound, outbound in
          self.outbound = outbound
          startListenSocketInput()
          transport?.socketDidSuccessConnect()
          
          for try await inboundData in inbound {
            var res = inboundData
            if let header = res.readBytes(length: Int(headerLength)) {
              let bodySize: UInt64 = uVarInt(header).value
              
              if let body = res.readBytes(length: Int(bodySize)) {
                let data = Data.init(body)
                outputSocketContinuation?.yield(with: .success(data))
              }
            }
          }
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func disconnect() {
    let _ =  self.clientChannel?.channel.close(mode: .all)
    self.clientChannel = nil
  }
  
  private func startListenSocketInput() {
    guard let transport = self.transport else { return }
    inputTask = Task {
      for await sendedData in transport.inputSocketStream {
        let requestData = self.appendHeader(to: sendedData.data)
        try? await outbound?.write(ByteBuffer(bytes: requestData))
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
