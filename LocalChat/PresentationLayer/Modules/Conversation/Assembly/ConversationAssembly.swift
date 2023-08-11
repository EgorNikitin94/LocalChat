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
  func build(dialog: Dialog, moduleOutput: ConversationModuleOutput?, completion: ((ConversationModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(dialog: dialog, model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as ConversationModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> ConversationModel {
    ConversationModel()
}
  
  private func buildIntent(dialog: Dialog, model: ConversationModel, moduleOutput: ConversationModuleOutput?) -> ConversationIntent {
    ConversationIntent(dialog: dialog, model: model, moduleOutput: moduleOutput)
}
  
  private func buildView(model: ConversationModel, intent: ConversationIntent) -> some View {
    let container = MVIContainer(
      intent: intent as ConversationIntentProtocol,
      model: model as ConversationModelStateProtocol,
      modelChangePublisher: model.objectWillChange)
    return ConversationView(container: container)
  }
  
}
