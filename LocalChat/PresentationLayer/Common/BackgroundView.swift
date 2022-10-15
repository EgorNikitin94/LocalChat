//
//  BackgroundView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import SwiftUI

struct BackgroundView<Content: View>: View {

  private var content: Content

  @Environment(\.colorScheme) private var colorScheme

  private var background: Color {
    AppColors.background.getColor(shame: colorScheme)
  }

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    background
      .ignoresSafeArea()
      .overlay(content)
  }
}
