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
  case sysInited(sessionId: String, pts: UInt32)
}
