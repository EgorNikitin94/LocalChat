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
  func build(
    moduleOutput: PhotoViewerModuleOutput?,
    completion: ((PhotoViewerModuleInput?) -> Void)?
  ) -> some View {
    let model = buildModel(moduleOutput: moduleOutput)
    let view = buildView(model: model)
    completion?(model as PhotoViewerModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel(moduleOutput: PhotoViewerModuleOutput?) -> PhotoViewerViewModel {
    PhotoViewerViewModelImpl(moduleOutput: moduleOutput)
  }
  
  @MainActor
  private func buildView(model: PhotoViewerViewModel) -> some View {
    return PhotoViewerView(vm: model)
  }
  
}
