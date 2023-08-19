//
//  ConversationRouter.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct ConversationRouter: RouterProtocol {
  typealias RouterScreenType = ScreenType
  typealias RouterAlertType = AlertScreen
  
  let subjects: Subjects
  let intent: ConversationIntentProtocol
}

// MARK: - Navigation Screens

extension ConversationRouter {
  enum ScreenType: RouterScreenProtocol {
    case mediaPicker
    
    var routeType: RouterScreenPresentationType {
      switch self {
      case .mediaPicker:
        return .sheet
      }
    }
  }
  
  @ViewBuilder
  func makeScreen(type: RouterScreenType) -> some View {
    switch type {
    case .mediaPicker:
      MediaPickerAssembly().build(moduleOutput: intent as? MediaPickerModuleOutput, completion: nil)
        .presentationDetents([.height(UIScreen.main.bounds.height * 0.7), .large])
    }
  }
  
  func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension ConversationRouter {
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
