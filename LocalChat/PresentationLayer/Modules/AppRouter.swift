//
//  AppRouter.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/27/22.
//

import SwiftUI
import Combine

enum Screen: Hashable {
  case auth
  case dialogsList
  case profile
  case conversation
  case chatInfo
}

protocol Completeable {
    var didComplete: PassthroughSubject<Self, Never> { get }
}

protocol Navigable: AnyObject, Identifiable, Hashable {}

extension Navigable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


final class AppRouter: ObservableObject {
  var subscription = Set<AnyCancellable>()
  
  @Published var navigationPath: [Screen] = []
  
  func pushInitialView() {
    let authorized = true
    let rootView: Screen = authorized ? .dialogsList : .auth
    navigationPath.append(rootView)
  }
  
  func pushAuthView() -> AuthView {
    let view = moduleAssembly.assemblyAuth()
    view.viewModel.didComplete
      .sink(receiveValue: didCompleteAuth)
      .store(in: &subscription)
    return view
  }
  
  func pushDialogsList() -> DialogsListView {
    let view = moduleAssembly.assemblyDialogsList()
    view.viewModel.didTapOnDialog
      .sink(receiveValue: didCompleteDialogsList)
      .store(in: &subscription)
    return view
  }
  
  func didCompleteAuth(vm: AuthViewModel) {
    navigationPath = [.dialogsList]
  }
  
  func didCompleteDialogsList(vm: DialogListRowViewModel) {
    navigationPath.append(.conversation)
  }
  
}
