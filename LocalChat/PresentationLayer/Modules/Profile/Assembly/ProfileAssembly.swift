//
//  ProfileAssembly.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

class ProfileAssembly {

// MARK: - Public
  func build(
    moduleOutput: ProfileModuleOutput?,
    completion: ((ProfileModuleInput?) -> Void)?
  ) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as ProfileModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> ProfileModel {
    ProfileModel()
}
  
  private func buildIntent(
    model: ProfileModel,
    moduleOutput: ProfileModuleOutput?
  ) -> ProfileIntent {
    ServicesCatalog.shared.register(service: MockUserService())
    return ProfileIntent(
      model: model,
      moduleOutput: moduleOutput,
      userService: ServicesCatalog.shared.userService
    )
}
  
  private func buildView(
    model: ProfileModel,
    intent: ProfileIntent
  ) -> some View {
    let container = ModernMVIContainer(
      intent: intent as ProfileIntentProtocol,
      model: model as ProfileModelStateProtocol
    )
    return ProfileView(container: container)
  }
  
}
