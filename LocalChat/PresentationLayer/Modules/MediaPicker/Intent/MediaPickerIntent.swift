//
//  MediaPickerIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class MediaPickerIntent {

  private weak var model:MediaPickerModelActionsProtocol?
  private weak var routeModel:MediaPickerModelRouterProtocol?
  private weak var moduleOutput:MediaPickerModuleOutput?

  init(model: (MediaPickerModelActionsProtocol & MediaPickerModelRouterProtocol)?, moduleOutput:MediaPickerModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
}

// MARK: - MediaPickerIntentProtocol
extension MediaPickerIntent: MediaPickerIntentProtocol {
  func viewOnAppear() {
    //
  }
}


// MARK: - MediaPickerModuleInput
extension MediaPickerIntent: MediaPickerModuleInput {
  
}