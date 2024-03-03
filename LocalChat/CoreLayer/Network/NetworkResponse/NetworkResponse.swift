//
//  NetworkResponse.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/18/24.
//

import Foundation

struct NetworkError: Error {
  let code: Int
  let reason: String
  let description: String
  
  init(with pbError: SysError) {
    self.code = Int(pbError.code)
    self.reason = pbError.reason
    self.description = pbError.description_p
  }
}

enum NetworkResponseError: Error {
  case error(NetworkError)
  case notImplementedInSubclass
  case notExpectedRequest
}

enum NetworkResponse {
  case unknown
  case bool(Bool)
  case sysInited(sessionId: String, pts: UInt32)
  case pong(id: UInt32)
}
