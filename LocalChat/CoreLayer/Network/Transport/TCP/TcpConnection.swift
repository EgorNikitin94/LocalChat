//
//  TcpTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/26/22.
//

import Foundation
import NIO

final class TcpConnection: NSObject {
  private let host = "localhost"
  private let port: Int = 8080
  private let group = MultiThreadedEventLoopGroup.singleton
  
  private var outbound: NIOAsyncChannelOutboundWriter<Data>? = nil
  private var clientChannel: NIOAsyncChannel<Data, Data>? = nil
  
  private(set) lazy var outputSocketStream: AsyncThrowingStream<Data, Error> = {
    AsyncThrowingStream { (continuation: AsyncThrowingStream<Data, Error>.Continuation) -> Void in
      self.outputSocketContinuation = continuation
    }
  }()
  
  private(set) var outputSocketContinuation: AsyncThrowingStream<Data, Error>.Continuation?
  
  func connect() {
    Task {
      let resolvedAddress = try SocketAddress.makeAddressResolvingHost(host, port: port)
      self.clientChannel = try await ClientBootstrap(group: group)
        .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
        .connectTimeout(TimeAmount(.seconds(40)))
        .connect(
          to: resolvedAddress
        ) { channel in
          return channel.eventLoop.makeCompletedFuture {
            return try NIOAsyncChannel<Data, Data>(
              wrappingChannelSynchronously: channel
            )
          }
        }
      
      try await self.clientChannel?.executeThenClose { inbound, outbound in
        self.outbound = outbound
        
        for try await inboundData in inbound {
          print(inboundData)
          outputSocketContinuation?.yield(with: .success(inboundData))
        }
      }
    }
    
  }
  
  func disconnect() {
    try? group.syncShutdownGracefully()
  }
  
  func send(data: Data, id: UInt32) {
    Task {
      try await outbound?.write(data)
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
