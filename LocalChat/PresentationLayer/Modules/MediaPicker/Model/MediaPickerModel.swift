//
//  MediaPickerModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit
import Combine

class PhotoDisplayItem: ObservableObject, Hashable {
  static func == (lhs: PhotoDisplayItem, rhs: PhotoDisplayItem) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  let id: UUID = UUID()
  let image: UIImage
  @Published var selected: Bool = false
  
  init(image: UIImage) {
    self.image = image
  }
}

class MediaPickerModel: ObservableObject, MediaPickerModelStateProtocol {
  @Published var imagesDisplayItems: [PhotoDisplayItem] = []
  let routerSubject = MediaPickerRouter.Subjects()
}

// MARK: - Actions
extension MediaPickerModel: MediaPickerModelActionsProtocol {
  func didLoadPhotosFromLibrary(_ images: [UIImage]) {
    imagesDisplayItems = images.map({ PhotoDisplayItem(image: $0) })
  }
}

// MARK: - Route
extension MediaPickerModel: MediaPickerModelRouterProtocol {
  func closeModule() {
    routerSubject.close.send()
  }
}
