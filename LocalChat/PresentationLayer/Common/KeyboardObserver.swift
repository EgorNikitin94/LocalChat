//
//  KeyboardObserver.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/1/24.
//

import SwiftUI
import Combine
import Observation

@Observable
class KeyboardObserver {
  var currentHeight: CGFloat = 0
  
  private var keyboardWillShowNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
  private var keyboardWillHideNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

  private var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    keyboardWillShowNotification
      .map { notification in
        CGFloat((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0)
      }
      .sink { [weak self] value in
        withAnimation {
          self?.currentHeight = value
        }
      }
//      .assign(to: \.currentHeight, on: self)
      .store(in: &cancellableSet)
    
    keyboardWillHideNotification
      .map { _ in
        CGFloat(0)
      }
      .sink { [weak self] value in
        withAnimation {
          self?.currentHeight = value
        }
      }
//      .assign(to: \.currentHeight, on: self)
      .store(in: &cancellableSet)
  }
}
