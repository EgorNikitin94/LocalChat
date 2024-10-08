// 
//  PhotoViewerModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import Foundation
import Observation

typealias PhotoViewerViewModel = PhotoViewerState & PhotoViewerIntent & PhotoViewerModuleInput

protocol PhotoViewerState {
  var assets: [PhotoViewerAsset] { get }
  var routerSubject: PhotoViewerRouter.Subjects { get }
}

protocol PhotoViewerIntent: AnyObject {
  func viewOnAppear()
  func reduce(_ action: PhotoViewerAction)
}

protocol PhotoViewerModuleInput: AnyObject {
  
}

protocol PhotoViewerModuleOutput: AnyObject {
  
}

enum PhotoViewerAsset: Identifiable {
  var id: UUID {
    switch self {
      case .photo(let asset): return asset.id
      case .video(let asset): return asset.id
    }
  }
  case photo(PHPhotoAsset)
  case video(PHVideoAsset)
}

@Observable
class PhotoViewerViewModelImpl: PhotoViewerState {
  var assets: [PhotoViewerAsset] = []
  let routerSubject = PhotoViewerRouter.Subjects()
  
  private weak var moduleOutput: PhotoViewerModuleOutput?
  private let assetsLoader: PhotosLoader
  
  init(moduleOutput: PhotoViewerModuleOutput?) {
    self.moduleOutput = moduleOutput
    self.assetsLoader = .init()
  }
}

// MARK: - PhotoViewerIntent
extension PhotoViewerViewModelImpl: PhotoViewerIntent {
  func viewOnAppear() {
    //
  }
  
  func reduce(_ action: PhotoViewerAction) {
    //
  }
}

// MARK: - PhotoViewerModuleInput
extension PhotoViewerViewModelImpl: PhotoViewerModuleInput {
  
}
