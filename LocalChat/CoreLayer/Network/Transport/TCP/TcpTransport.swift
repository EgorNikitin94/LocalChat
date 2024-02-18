//
//  TCPTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation

protocol TcpTransportInterface: AnyObject {
  var inputSocketStream: AsyncStream<(data: Data, id: UInt32)> { get }
  func socketDidSuccessConnect()
}

class TcpTransport {
  static let shared = TcpTransport()
  private var connection: TcpConnection
  
  weak var requestDispatcher: RequestDispatcher?
  
  private var outputTask: Task<(), Never>?
  
  private(set) lazy var inputSocketStream: AsyncStream<(data: Data, id: UInt32)> = {
    AsyncStream { (continuation: AsyncStream<(data: Data, id: UInt32)>.Continuation) -> Void in
      self.inputSocketContinuation = continuation
    }
  }()
  
  private var inputSocketContinuation: AsyncStream<(data: Data, id: UInt32)>.Continuation?
  
  init() {
    self.connection = TcpConnection()
    self.connection.transport = self
  }
  
  func startListenSocketOutput() {
    outputTask = Task {
      do {
        for try await resivedData in connection.outputSocketStream {
          await requestDispatcher?.didGet(data: resivedData)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func send(request: Request) {
    do {
      let data = try request.serializedData()
      inputSocketContinuation?.yield((data, request.id))
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func setupConnection() {
    connection.connect()
    startListenSocketOutput()
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

extension TcpTransport: TcpTransportInterface {
  func socketDidSuccessConnect() {
    lendHand()
  }
}
