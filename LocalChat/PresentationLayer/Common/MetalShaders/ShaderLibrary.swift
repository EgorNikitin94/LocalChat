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
  @Binding var isOn: Bool
  
  func body(content: Content) -> some View {
    content
      .colorEffect(
        ShaderLibrary.monochrome(),
        isEnabled: isOn
      )
  }
}

extension View {
  func monochrome(
    isOn: Binding<Bool> = .constant(true)
  ) -> some View {
    modifier(Monochrome(isOn: isOn))
  }
}
