//
//  ProfileIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class ProfileIntent {

  private weak var model: ProfileModelActionsProtocol?
  private weak var routeModel: ProfileModelRouterProtocol?
  private weak var moduleOutput: ProfileModuleOutput?
  
  private let userService: UserServiceProtocol

  init(
    model: (ProfileModelActionsProtocol & ProfileModelRouterProtocol)?,
    moduleOutput:ProfileModuleOutput?,
    userService: UserServiceProtocol
  ) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.userService = userService
  }
  
}

// MARK: - ProfileIntentProtocol
extension ProfileIntent: ProfileIntentProtocol {
  func viewOnAppear() {
    let me = userService.currentUser
  }
}


// MARK: - ProfileModuleInput
extension ProfileIntent: ProfileModuleInput {
  
}
