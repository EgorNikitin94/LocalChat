//
//  AuthRouter.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct AuthRouter: RouterProtocol {
  typealias RouterScreenType = ScreenType
  typealias RouterAlertType = AlertScreen
  
  let subjects: Subjects
  let intent: AuthIntentProtocol
}

// MARK: - Navigation Screens

extension AuthRouter {
  enum ScreenType: RouterScreenProtocol {
    case testNavigation(param: Any)
    
    var routeType: RouterScreenPresentationType {
      switch self {
      case .testNavigation:
        return .sheet
      }
    }
  }
  
  @ViewBuilder
  func makeScreen(type: RouterScreenType) -> some View {
    switch type {
    case .testNavigation(_):
      Text("Hallo new amo module!")
    }
  }
  
  func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension AuthRouter {
  enum AlertScreen: RouterAlertScreenProtocol {
    case defaultAlert(title: String, message: String?)
  }
  
  func makeAlert(type: RouterAlertType) -> Alert {
    switch type {
    case let .defaultAlert(title, message):
      return Alert(title: Text(title),
                   message: message.map { Text($0) },
                   dismissButton: .cancel(Text("Cancel")))
    }
  }
}
