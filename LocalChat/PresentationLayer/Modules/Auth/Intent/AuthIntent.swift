//
//  AuthIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class AuthIntent {

  private weak var model: AuthModelActionsProtocol?
  private weak var routeModel: AuthModelRouterProtocol?
  private weak var moduleOutput: AuthModuleOutput?
  private var authService: AuthServiceProtocol

  init(
    model: (AuthModelActionsProtocol & AuthModelRouterProtocol)?,
    moduleOutput: AuthModuleOutput?,
    authService: AuthServiceProtocol
  ) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.authService = authService
  }
  
}

// MARK: - AuthIntentProtocol
extension AuthIntent: AuthIntentProtocol {
  func viewOnAppear() {
    //
  }
  
  func didChangeLogin(with value: String) {
    if !value.isEmpty {
      model?.changeState(.passwordFieldEnabled)
    } else {
      model?.changeState(.none)
    }
  }
  
  func didChangePassword(with value: String) {
    if !value.isEmpty {
      model?.changeState(.buttonEnabled)
    } else {
      model?.changeState(.passwordFieldEnabled)
    }
  }
  
  func didTapSignIn() {
    routeModel?.didTapSignIn()
  }
}


// MARK: - AuthModuleInput
extension AuthIntent: AuthModuleInput {
  
}
