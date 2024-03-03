//
//  NetworkResponse.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/18/24.
//

import Foundation

enum NetworkResponseError: Error {
  case notImplementedInSubclass
  case notExpectedRequest
}

enum NetworkResponse {
  case unknown
  case bool(Bool)
  case sysInited(sessionId: String, pts: UInt32)
  case pong(id: UInt32)
}
