// 
//  RootAssembly.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

class RootAssembly {
  
  // MARK: - Public
  func build(moduleOutput: RootModuleOutput?, completion: ((RootModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as RootModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> RootModel {
  RootModel()
  }
  
  private func buildIntent(model: RootModel, moduleOutput: RootModuleOutput?) -> RootIntent {
  RootIntent(model: model, moduleOutput: moduleOutput)
  }
  
  private func buildView(model: RootModel, intent: RootIntent) -> some View {
    let container = MVIContainer(
      intent: intent as RootIntentProtocol,
      model: model as RootModelStateProtocol,
      modelChangePublisher: model.objectWillChange)
    return RootView(container: container)
  }
  
}
