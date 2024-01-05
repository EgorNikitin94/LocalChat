//
//  View+Modify.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

extension View {
  func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
    return modifier(self)
  }
}
