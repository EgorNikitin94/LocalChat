//
//  IdCounter.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/14/24.
//

import Foundation

actor RequestIdCounter {
  static let shared = RequestIdCounter()
  
  private var _requestId: UInt32 = 0
  
  var requestId: UInt32 {
    _requestId += 1
    return _requestId
  }
}
