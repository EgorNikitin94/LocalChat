//
//  MediaPickerModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit
import Combine

class PhotoDisplayItem: ObservableObject, Hashable, Equatable, Identifiable {
  static func == (lhs: PhotoDisplayItem, rhs: PhotoDisplayItem) -> Bool {
    lhs.id == rhs.id && lhs.selected == rhs.selected
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  let id: UUID = UUID()
  let image: UIImage
  @Published var selected: Bool = false
  @Published var number: String? = nil
  
  init(image: UIImage) {
    self.image = image
  }
}

class MediaPickerModel: ObservableObject, MediaPickerModelStateProtocol {
  @Published var imagesDisplayItems: [PhotoDisplayItem] = []
  @Published var selectedItemsCount: Int = 0
  let routerSubject = MediaPickerRouter.Subjects()
}

// MARK: - Actions
extension MediaPickerModel: MediaPickerModelActionsProtocol {
  func didLoadPhotosFromLibrary(_ images: [UIImage]) {
    imagesDisplayItems = images.map({ PhotoDisplayItem(image: $0) })
  }
  
  func didSelectItem(_ item: PhotoDisplayItem) {
    if let fItem = imagesDisplayItems.first(where: { $0.id == item.id }) {
      if fItem.selected {
        let bItems = imagesDisplayItems.filter({Int($0.number ?? "0") ?? 0 > Int(fItem.number ?? "0") ?? 0  })
        bItems.forEach { item in
          if let number = item.number, let intNumber = Int(number) {
            item.number = String(intNumber - 1)
          }
        }
        fItem.selected = false
        selectedItemsCount -= 1
      } else {
        fItem.selected = true
        selectedItemsCount += 1
      }
      
      fItem.number = fItem.selected ? String(selectedItemsCount) : ""
    }
  }
}

// MARK: - Route
extension MediaPickerModel: MediaPickerModelRouterProtocol {
  func closeModule() {
    routerSubject.close.send()
  }
}
