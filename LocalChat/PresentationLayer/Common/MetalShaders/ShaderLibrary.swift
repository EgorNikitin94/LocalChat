//
//  ShaderLibrary.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/2/24.
//

import SwiftUI

struct ShaderLibrary {
  static func monochrome() -> Shader {
    Shader(
      function: ShaderFunction(
        library: .default,
        name: "monochrome"
      ),
      arguments: []
    )
  }
}

struct Monochrome: ViewModifier {
  func body(content: Content) -> some View {
    content
      .colorEffect(ShaderLibrary.monochrome())
  }
}

extension View {
  func monochrome() -> some View {
    modifier(Monochrome())
  }
}
