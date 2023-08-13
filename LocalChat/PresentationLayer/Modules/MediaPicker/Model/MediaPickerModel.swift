//
//  MediaPickerModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Combine

class MediaPickerModel: ObservableObject, MediaPickerModelStateProtocol {
  let routerSubject = MediaPickerRouter.Subjects()
}

// MARK: - Actions
extension MediaPickerModel: MediaPickerModelActionsProtocol {
  
}

// MARK: - Route
extension MediaPickerModel: MediaPickerModelRouterProtocol {
  
}