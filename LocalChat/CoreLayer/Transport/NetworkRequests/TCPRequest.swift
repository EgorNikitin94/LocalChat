//
//  TCPRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

class TCPRequest: NetworkRequest {
  let id: UInt32
  let request: Request
  
  var priority: RequestPriority {
    .standart
  }
  
  init(
    id: UInt32,
    request: Request
  ) {
    self.id = id
    self.request = request
  }
}
