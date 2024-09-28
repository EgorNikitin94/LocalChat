// 
//  RootAssembly.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

class RootAssembly {
  
  // MARK: - Public
  @MainActor func build(moduleOutput: RootModuleOutput?, completion: ((RootModuleInput?) -> Void)?) -> some View {
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
  
  @MainActor private func buildView(model: RootModel, intent: RootIntent) -> some View {
    let container = ModernMVIContainer(
      intent: intent as RootIntentProtocol,
      model: model as RootModelStateProtocol
    )
    
    let childViews = buildChildSubmodules(with: intent)
    
    return RootView(
      container: container,
      contacts: childViews.contactsView,
      dialogsList: childViews.dialogsList,
      settings: childViews.settings
    )
  }
  
  @MainActor func buildChildSubmodules(with intent: RootIntent) -> (contactsView: some View, dialogsList: some View, settings: some View) {
    let contacts = Text("Contacts")
    let dialogs = DialogsListAssembly().build(moduleOutput: intent) { input in
      intent.dialigsListInput = input
    }
    let settings = ProfileAssembly().build(moduleOutput: intent) { input in
      intent.profileModuleInput = input
    }
    return (contacts, dialogs, settings)
  }
  
}
