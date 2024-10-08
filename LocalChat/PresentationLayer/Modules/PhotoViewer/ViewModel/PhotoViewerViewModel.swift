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

@Observable
class PhotoViewerViewModelImpl: PhotoViewerState {
  private weak var moduleOutput: PhotoViewerModuleOutput?
  let routerSubject = PhotoViewerRouter.Subjects()
  
  init(moduleOutput: PhotoViewerModuleOutput?) {
    self.moduleOutput = moduleOutput
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
