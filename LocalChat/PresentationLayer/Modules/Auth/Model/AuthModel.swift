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
  var login: String = "" {
    didSet {
      passwordFieldEnabled = !login.isEmpty
    }
  }
  var password: String = "" {
    didSet {
      buttonEnabled = !password.isEmpty
    }
  }
  var passwordFieldEnabled = false
  var buttonEnabled = false
  let routerSubject = AuthRouter.Subjects()
}

// MARK: - Actions
extension AuthModel: AuthModelActionsProtocol {
  
}

// MARK: - Route
extension AuthModel: AuthModelRouterProtocol {
  func didTapSignIn() {
    routerSubject.screen.send(.testNavigation(param: 1))
  }
}
