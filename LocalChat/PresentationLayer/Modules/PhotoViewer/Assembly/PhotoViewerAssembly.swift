// 
//  PhotoViewerAssembly.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import SwiftUI

class PhotoViewerAssembly {
  
  // MARK: - Public
  @MainActor
  func build(moduleOutput: PhotoViewerModuleOutput?, completion: ((PhotoViewerModuleInput?) -> Void)?) -> some View {
    let model = buildModel()
    let intent = buildIntent(model: model, moduleOutput: moduleOutput)
    let view = buildView(model: model, intent: intent)
    completion?(intent as PhotoViewerModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel() -> PhotoViewerModel {
  PhotoViewerModel()
  }
  
  private func buildIntent(model: PhotoViewerModel, moduleOutput: PhotoViewerModuleOutput?) -> PhotoViewerIntent {
  PhotoViewerIntent(model: model, moduleOutput: moduleOutput)
  }
  
  @MainActor
  private func buildView(model: PhotoViewerModel, intent: PhotoViewerIntent) -> some View {
    let container = ModernMVIContainer(
      intent: intent as PhotoViewerIntentProtocol,
      model: model as PhotoViewerModelStateProtocol
    )
    return PhotoViewerView(container: container)
  }
  
}
