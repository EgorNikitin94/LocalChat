//
//  DialogsListAssembly.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

class DialogsListAssembly {

// MARK: - Public
  func build(moduleOutput: DialogsListModuleOutput?, completion: ((DialogsListModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as DialogsListModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> DialogsListModel {
    DialogsListModel()
}
  
  private func buildIntent(model: DialogsListModel, moduleOutput: DialogsListModuleOutput?) -> DialogsListIntent {
    DialogsListIntent(model: model, moduleOutput: moduleOutput, dialogService: MockDialogsService())
}
  
  private func buildView(model: DialogsListModel, intent: DialogsListIntent) -> some View {
    let container = MVIContainer(
      intent: intent as DialogsListIntentProtocol,
      model: model as DialogsListModelStateProtocol,
      modelChangePublisher: model.objectWillChange)
    return DialogsListView(container: container)
  }
  
}
