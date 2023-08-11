//
//  ProfileIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class ProfileIntent {

  private weak var model:ProfileModelActionsProtocol?
  private weak var routeModel:ProfileModelRouterProtocol?
  private weak var moduleOutput:ProfileModuleOutput?

  init(model: (ProfileModelActionsProtocol & ProfileModelRouterProtocol)?, moduleOutput:ProfileModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
}

// MARK: - ProfileIntentProtocol
extension ProfileIntent: ProfileIntentProtocol {
  func viewOnAppear() {
    //
  }
}


// MARK: - ProfileModuleInput
extension ProfileIntent: ProfileModuleInput {
  
}