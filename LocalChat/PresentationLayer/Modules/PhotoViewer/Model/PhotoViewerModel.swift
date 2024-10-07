// 
//  PhotoViewerModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import Foundation
import Observation

@Observable
class PhotoViewerModel: PhotoViewerModelStateProtocol {
  let routerSubject = PhotoViewerRouter.Subjects()
}

// MARK: - Actions
extension PhotoViewerModel: PhotoViewerModelActionsProtocol {
  
}

// MARK: - Route
extension PhotoViewerModel: PhotoViewerModelRouterProtocol {
  
}
