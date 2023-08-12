//
//  TcpTransport.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/26/22.
//

import Foundation
import CocoaAsyncSocket

final class TcpTramsport: NSObject, URLSessionStreamDelegate {
  private let urlSession: URLSession = URLSession.shared
  private var streamTask: URLSessionStreamTask!
  
  override init() {
    super.init()
    
    streamTask = urlSession.streamTask(withHostName: "", port: 443)
    
  }
}
