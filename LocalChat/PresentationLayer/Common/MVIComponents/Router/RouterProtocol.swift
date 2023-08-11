//
//  RouterProtocol.swift
//  amomessenger
//
//  Created by Egor Nikitin on 08/06/2023.
//  Copyright © 2023 amoCRM. All rights reserved.
//

import Combine
import SwiftUI

// MARK: - AppRouterProtocol

protocol RouterProtocol: ViewModifier {
  associatedtype RouterScreenType: RouterScreenProtocol
  associatedtype RouterAlertType: RouterAlertScreenProtocol
  associatedtype RouterScreen: View
  
  typealias Subjects = RouterSubjects<RouterScreenType, RouterAlertType>
  
  var subjects: Subjects { get }
  
  func makeScreen(type: RouterScreenType) -> RouterScreen
  func makeAlert(type: RouterAlertType) -> Alert
  
  func onDismiss(screenType: RouterScreenType)
}

extension RouterProtocol {
  func body(content: Content) -> some View {
    content
      .modifier(RouterNavigationViewModifier(
        publisher: subjects.screen.filter { $0.routeType == .navigationLink }.eraseToAnyPublisher(),
        screen: makeScreen,
        onDismiss: onDismiss))
      .modifier(RouterNavigationStackModifier(
        publisher: subjects.screen.filter { $0.routeType == .navigationDestination }.eraseToAnyPublisher(),
        screen: makeScreen,
        onDismiss: onDismiss))
      .modifier(RouterAlertModifier(
        publisher: subjects.alert.eraseToAnyPublisher(),
        alert: makeAlert))
      .modifier(RouterCloseModifier(
        publisher: subjects.close.eraseToAnyPublisher()))
      .modifier(RouterSheetModifier(
        isFullScreenCover: false,
        publisher: subjects.screen.filter { $0.routeType == .sheet }.eraseToAnyPublisher(),
        screen: makeScreen,
        onDismiss: onDismiss))
      .modifier(RouterSheetModifier(
        isFullScreenCover: true,
        publisher: subjects.screen.filter { $0.routeType == .fullScreenCover }.eraseToAnyPublisher(),
        screen: makeScreen,
        onDismiss: onDismiss))
  }
  
  func onDismiss(screenType: RouterScreenType) {}
}

// MARK: Support open module from UIKit Viper
extension RouterProtocol {
  static func openModule(_ view: UIViewController?,
                         from viewController: UIViewController?,
                         animated: Bool) {
    guard let view = view,
          let viewController = viewController
    else {
      return
    }
    if let viewController = viewController as? UINavigationController {
      viewController.pushViewController(view, animated: animated)
    } else if let viewController = viewController.navigationController {
      viewController.pushViewController(view, animated: animated)
    } else {
      viewController.present(view, animated: animated, completion: nil)
    }
  }
  
  static func openModule(_ view: UIViewController?,
                         viewController: UIViewController?,
                         inView: UIView,
                         onFullViewArea: Bool) {
    guard let view = view,
          let viewController = viewController
    else {
      return
    }
    
    viewController.addChild(view)
    if let child = view.view {
      child.frame = inView.bounds
      inView.addSubview(child)
      if onFullViewArea {
        child.leadingAnchor.constraint(equalTo: inView.leadingAnchor).isActive = true
        child.trailingAnchor.constraint(equalTo: inView.trailingAnchor).isActive = true
        child.topAnchor.constraint(equalTo: inView.topAnchor).isActive = true
        child.bottomAnchor.constraint(equalTo: inView.bottomAnchor).isActive = true
        child.translatesAutoresizingMaskIntoConstraints = false
      }
    }
    view.didMove(toParent: viewController)
  }
  
  static func modalPresent(_ view: UIViewController?,
                           viewController: UIViewController?,
                           presentationStyle: UIModalPresentationStyle = .pageSheet,
                           animated: Bool) {
    guard let view = view,
          let viewController = viewController
    else {
      return
    }
    view.modalPresentationStyle = presentationStyle
    viewController.present(view, animated: animated)
  }
}

// MARK: - Helper classes

struct RouterSubjects<ScreenType, AlertType> where ScreenType: RouterScreenProtocol, AlertType: RouterAlertScreenProtocol {
  let screen = PassthroughSubject<ScreenType, Never>()
  let alert = PassthroughSubject<AlertType, Never>()
  let close = PassthroughSubject<Void, Never>()
}

