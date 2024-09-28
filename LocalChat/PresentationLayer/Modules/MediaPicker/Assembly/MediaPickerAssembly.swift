//
//  MediaPickerAssembly.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

class MediaPickerAssembly {

// MARK: - Public
  @MainActor func build(moduleOutput: MediaPickerModuleOutput?, completion: ((MediaPickerModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as MediaPickerModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> MediaPickerModel {
    MediaPickerModel()
}
  
  private func buildIntent(model: MediaPickerModel, moduleOutput: MediaPickerModuleOutput?) -> MediaPickerIntent {
    MediaPickerIntent(model: model, moduleOutput: moduleOutput)
}
  
  @MainActor private func buildView(model: MediaPickerModel, intent: MediaPickerIntent) -> some View {
    let container = ModernMVIContainer(
      intent: intent as MediaPickerIntentProtocol,
      model: model as MediaPickerModelStateProtocol
    )
    return MediaPickerView(container: container)
  }
  
}
