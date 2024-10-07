// 
//  PhotoViewerIntent.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import Foundation

class PhotoViewerIntent {
  
  private weak var model:PhotoViewerModelActionsProtocol?
  private weak var routeModel:PhotoViewerModelRouterProtocol?
  private weak var moduleOutput:PhotoViewerModuleOutput?
  
  init(model: (PhotoViewerModelActionsProtocol & PhotoViewerModelRouterProtocol)?, moduleOutput:PhotoViewerModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
}

// MARK: - PhotoViewerIntentProtocol
extension PhotoViewerIntent: PhotoViewerIntentProtocol {
  func viewOnAppear() {
    //
  }
}


// MARK: - PhotoViewerModuleInput
extension PhotoViewerIntent: PhotoViewerModuleInput {
  
}
