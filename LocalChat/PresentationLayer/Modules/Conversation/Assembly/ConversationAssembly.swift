//
//  ConversationAssembly.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

class ConversationAssembly {

// MARK: - Public
  @MainActor func build(peer: User, moduleOutput: ConversationModuleOutput?, completion: ((ConversationModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(peer: peer, model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as ConversationModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> ConversationModel {
    ConversationModel()
}
  
  private func buildIntent(peer: User, model: ConversationModel, moduleOutput: ConversationModuleOutput?) -> ConversationIntent {
    ConversationIntent(peer: peer, model: model, moduleOutput: moduleOutput)
}
  
  @MainActor private func buildView(model: ConversationModel, intent: ConversationIntent) -> some View {
    let container = ModernMVIContainer(
      intent: intent as ConversationIntentProtocol,
      model: model as ConversationModelStateProtocol
    )
    return ConversationView(container: container)
  }
  
}
