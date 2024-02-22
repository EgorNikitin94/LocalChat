//
//  AuthAssembly.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

class AuthAssembly {

// MARK: - Public
  func build(moduleOutput: AuthModuleOutput?, completion: ((AuthModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as AuthModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> AuthModel {
    AuthModel()
}
  
  private func buildIntent(model: AuthModel, moduleOutput: AuthModuleOutput?) -> AuthIntent {
    AuthIntent(
      model: model,
      moduleOutput: moduleOutput,
      authService: ServicesCatalog.shared.authService
    )
}
  
  private func buildView(model: AuthModel, intent: AuthIntent) -> some View {
    let container = ModernMVIContainer(
      intent: intent as AuthIntentProtocol,
      model: model as AuthModelStateProtocol
    )
    return AuthView(container: container)
  }
  
}
