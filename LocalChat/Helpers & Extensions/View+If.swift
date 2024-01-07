//
//  View+If.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

extension View {
  @ViewBuilder
  func `if`<Transform: View>(
    _ condition: Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
