//
//  MediaPickerRouter.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct MediaPickerRouter: RouterProtocol {
  typealias RouterScreenType = ScreenType
  typealias RouterAlertType = AlertScreen
  
  let subjects: Subjects
  let intent: MediaPickerIntentProtocol
}

// MARK: - Navigation Screens

extension MediaPickerRouter {
  enum ScreenType: RouterScreenProtocol {
    case photoViewer(id: UUID, image: UIImage, namespace: Namespace.ID)
    
    var routeType: RouterScreenPresentationType {
      switch self {
      case .photoViewer(_, _, _):
        return .fullScreenCover
      }
    }
  }
  
  @ViewBuilder
  func makeScreen(type: RouterScreenType) -> some View {
    switch type {
    case .photoViewer(let id, let image, let namespace):
      PhotoViewer(image: image)
        .navigationTransition(.zoom(sourceID: id, in: namespace))
    }
  }
  
  func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension MediaPickerRouter {
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
