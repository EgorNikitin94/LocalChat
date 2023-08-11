//
//  AuthIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class AuthIntent {

  private weak var model:AuthModelActionsProtocol?
  private weak var routeModel:AuthModelRouterProtocol?
  private weak var moduleOutput:AuthModuleOutput?

  init(model: (AuthModelActionsProtocol & AuthModelRouterProtocol)?, moduleOutput:AuthModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
}

// MARK: - AuthIntentProtocol
extension AuthIntent: AuthIntentProtocol {
  func viewOnAppear() {
    //
  }
}


// MARK: - AuthModuleInput
extension AuthIntent: AuthModuleInput {
  
}