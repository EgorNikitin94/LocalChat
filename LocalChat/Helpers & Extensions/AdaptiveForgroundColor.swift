//
//  AdaptiveForgroundColor.swift
//  ConverterPro
//
//  Created by Егор Никитин on 23.02.2022.
//

import SwiftUI

struct AdaptiveForegroundColorModifier: ViewModifier {
  var appColor: AppColor
  
  @Environment(\.colorScheme) private var colorScheme
  
  func body(content: Content) -> some View {
    content.foregroundColor(resolvedColor)
  }
  
  private var resolvedColor: Color {
    switch colorScheme {
    case .light:
      return Color(uiColor: appColor.lightModeColor)
    case .dark:
      return Color(uiColor: appColor.darkModeColor)
    @unknown default:
      return Color(uiColor: appColor.lightModeColor)
    }
  }
}

extension View {
  func foregroundColor(
    color: AppColor
  ) -> some View {
    modifier(AdaptiveForegroundColorModifier(appColor: color))
  }
}
