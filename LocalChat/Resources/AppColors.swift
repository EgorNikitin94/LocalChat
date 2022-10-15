//
//  AppColors.swift
//  ConverterPro
//
//  Created by Егор Никитин on 23.02.2022.
//

import SwiftUI

struct AppColor {
  let lightModeColor:UIColor
  let darkModeColor:UIColor
  
  func getColor(shame: ColorScheme) -> Color {
    switch shame {
    case .light:
      return Color(uiColor: lightModeColor)
    case .dark:
      return Color(uiColor: darkModeColor)
    @unknown default:
      return Color(uiColor: lightModeColor)
    }
  }
}

enum AppColors {
  static let primary: AppColor = AppColor(lightModeColor: .white, darkModeColor: .black)
  static let background: AppColor = AppColor(lightModeColor: .white, darkModeColor: .systemGray6)
  static let numInput: AppColor = AppColor(lightModeColor: .systemGray5, darkModeColor: .systemGray2)
  static let selected: AppColor = AppColor(lightModeColor: .orange, darkModeColor: .orange)
}
