//
//  AuthModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Observation

@Observable
class AuthModel: AuthModelStateProtocol {
  var login: String = ""
  var password: String = ""
  var passwordFieldEnabled = false
  var buttonEnabled = false
  var state: State = .none
  let routerSubject = AuthRouter.Subjects()
  
  enum State: Int {
    case none
    case passwordFieldEnabled
    case buttonEnabled
  }
}

// MARK: - Actions
extension AuthModel: AuthModelActionsProtocol {
  func changeState(_ newState: AuthModel.State) {
    state = newState
  }
}

// MARK: - Route
extension AuthModel: AuthModelRouterProtocol {
  func didTapSignIn() {
    routerSubject.screen.send(.testNavigation(param: 1))
  }
}
