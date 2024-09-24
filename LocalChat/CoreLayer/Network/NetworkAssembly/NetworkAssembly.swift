//
//  NetworkAssembly.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

final class NetworkAssembly {
  nonisolated(unsafe) static let shared = NetworkAssembly()
  
  lazy var requestDispatcher: RequestDispatcher = {
    let tcpTrasport = self.tcpTransport
    let requestDispatcher = RequestDispatcher(tcpTransport: tcpTrasport)
    tcpTrasport.requestDispatcher = requestDispatcher
    return requestDispatcher
  }()
  
  lazy var tcpTransport: TcpTransport = {
    let tcpTransport = TcpTransport()
    return tcpTransport
  }()
}
