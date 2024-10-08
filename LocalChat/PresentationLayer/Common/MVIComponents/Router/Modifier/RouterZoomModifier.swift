//
//  RouterZoomModifier.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/24.
//

import SwiftUI
import Combine

protocol RouterZoomScreenProtocol {}

struct RouterZoomModifier<Screen, ScreenType> where Screen: View, ScreenType: RouterZoomScreenProtocol {
  
  // MARK: Public
  let publisher: AnyPublisher<ScreenType, Never>
  var id: UUID?
  var namespace: Namespace.ID?
  var screen: (ScreenType) -> Screen
  let onDismiss: ((ScreenType) -> Void)?
  
  // MARK: Private
  @State private var screenType: ScreenType?
}

// MARK: - ViewModifier

extension RouterZoomModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fullScreenCover(
        isPresented: Binding<Bool>(
          get: { screenType != nil },
          set: {
            if !$0 {
              if let type = screenType { onDismiss?(type) }
              screenType = nil
            }
          }),
        content: {
          if let type = screenType, let id = id, let namespace = namespace {
            screen(type)
              .navigationTransition(.zoom(sourceID: id, in: namespace))
          } else {
            EmptyView()
          }
        })
      .onReceive(publisher) { screenType = $0 }
  }
}
