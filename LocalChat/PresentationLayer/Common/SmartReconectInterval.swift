//
//  SmartReconectInterval.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/28/24.
//

import Foundation

class SmartReconectInterval {
  private var time: Duration
  private let type: SmartReconectIntervalType
  
  enum SmartReconectIntervalType {
    case linear(duration: Duration)
    case progressive(duration: Duration, scale: Double, lag: Duration)
  }
  
  init(with type: SmartReconectIntervalType) {
    self.type = type
    self.time = switch type {
    case .linear(let duration):
      duration
    case .progressive(let duration, _, _):
      duration
    }
  }
  
  func startAfterDelay() async {
    time = switch type {
    case .linear(_):
      time
    case .progressive(_, let scale, let lag):
      (time * scale) + lag
    }
    try? await Task.sleep(for: time)
  }
}
