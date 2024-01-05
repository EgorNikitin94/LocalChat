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
  
  init() {
    self.connection = TcpConnection()
  }
  
  func setupConnection() {
    connection.connect()
  }
}
