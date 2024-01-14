//
//  TCPTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation

class TcpTransport {
  static let shared = TcpTransport()
  private var connection: TcpConnection
  
  weak var requestDispatcher: RequestDispatcher?
  
  init() {
    self.connection = TcpConnection()
  }
  
  func listenSocketOutput() {
    Task {
      do {
        for try await resivedData in connection.outputSocketStream {
          await requestDispatcher?.didGet(data: resivedData)
        }
      } catch {
        //
      }
    }
  }
  
  func send(request: Request) {
    do {
      let data = try request.serializedData()
      connection.send(data: data, id: request.id)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func setupConnection() {
    connection.connect()
    listenSocketOutput()
  }
}
