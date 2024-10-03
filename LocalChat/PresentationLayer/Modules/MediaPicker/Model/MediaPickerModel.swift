//
//  MediaPickerModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Observation

@Observable
class PhotoDisplayItem: Hashable, Equatable, Identifiable {
  static func == (lhs: PhotoDisplayItem, rhs: PhotoDisplayItem) -> Bool {
    lhs.id == rhs.id && lhs.selected == rhs.selected
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  @ObservationIgnored let id: UUID = UUID()
  @ObservationIgnored let asset: any PHMediaAsset
  @ObservationIgnored var image: UIImage? = nil
  var selected: Bool = false
  var number: String? = nil
  
  init(asset: any PHMediaAsset) {
    self.asset = asset
  }
}

struct MediaButton: Identifiable {
  let id: UUID = UUID()
  let imageName: String
  let title: String
  let type: MediaButtonType
}

@Observable
class MediaPickerModel: MediaPickerModelStateProtocol {
  var imagesDisplayItems: [PhotoDisplayItem] = []
  @ObservationIgnored var buttons: [MediaButton] = [MediaButton(imageName: "photo.stack", title: String(localized:"Gallery"), type: .gallery),
                                MediaButton(imageName: "camera.fill", title: String(localized:"Camera"), type: .camera),
                                MediaButton(imageName: "folder.fill", title: String(localized:"Files"), type: .files)]
  var selectedItemsCount: Int = 0
  let routerSubject = MediaPickerRouter.Subjects()
}

// MARK: - Actions
extension MediaPickerModel: MediaPickerModelActionsProtocol {
  func didLoadPhotosFromLibrary(_ assets: [any PHMediaAsset]) {
    imagesDisplayItems = assets.map({ PhotoDisplayItem(asset: $0) })
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
  func presentPhotoViewer(_ item: PhotoDisplayItem, namespace: Namespace.ID) {
    if let phPhotoAsset = item.asset as? PHPhotoAsset, let image = item.image {
      routerSubject.screen.send(
        .photoViewer(
          id: item.id,
          asset: phPhotoAsset,
          image: image,
          namespace: namespace
        )
      )
    }
  }
  
  func closeModule() {
    routerSubject.close.send()
  }
}
