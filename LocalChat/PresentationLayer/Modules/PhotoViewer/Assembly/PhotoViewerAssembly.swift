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
    input: (any PHMediaAsset, UIImage)? = nil,
    moduleOutput: PhotoViewerModuleOutput?,
    completion: ((PhotoViewerModuleInput?) -> Void)?
  ) -> some View {
    let model = buildModel(moduleOutput: moduleOutput, input: input)
    let view = buildView(model: model)
    completion?(model as PhotoViewerModuleInput)
    return view
  }
  
  // MARK: - Private
  private func buildModel(
    moduleOutput: PhotoViewerModuleOutput?,
    input: (any PHMediaAsset, UIImage)? = nil
  ) -> PhotoViewerViewModel {
    PhotoViewerViewModelImpl(moduleOutput: moduleOutput, input: input)
  }
  
  @MainActor
  private func buildView(model: PhotoViewerViewModel) -> some View {
    return PhotoViewerView(vm: model)
  }
  
}
