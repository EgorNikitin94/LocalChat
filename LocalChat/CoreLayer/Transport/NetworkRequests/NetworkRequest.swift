//
//  NetworkRequest.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/13/24.
//

import Foundation

enum RequestPriority {
  case standart
  case action
  case high
  case sysInit
}

protocol NetworkRequest {
  var id: UInt32 { get }
  var priority: RequestPriority { get }
  var request: Request { get }
}

extension NetworkRequest {
}
