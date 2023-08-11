//
//  DialogsListRouter.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct DialogsListRouter: RouterProtocol {
  typealias RouterScreenType = ScreenType
  typealias RouterAlertType = AlertScreen
  
  let subjects: Subjects
  let intent: DialogsListIntentProtocol
}

// MARK: - Navigation Screens

extension DialogsListRouter {
  enum ScreenType: RouterScreenProtocol {
    case conversation(peer: User)
    case profile
    
    var routeType: RouterScreenPresentationType {
      switch self {
      case .conversation:
        return .navigationDestination
      case .profile:
        return .navigationDestination
      }
    }
  }
  
  @ViewBuilder
  func makeScreen(type: RouterScreenType) -> some View {
    switch type {
    case .conversation(let user):
      ConversationAssembly().build(peer: user, moduleOutput: nil, completion: nil)
    case .profile:
      ProfileAssembly().build(moduleOutput: nil, completion: nil)
    }
  }
  
  func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension DialogsListRouter {
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
