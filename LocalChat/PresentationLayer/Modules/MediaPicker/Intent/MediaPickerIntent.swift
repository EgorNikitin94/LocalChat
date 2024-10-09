//
//  MediaPickerIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Photos

enum MediaButtonType {
  case gallery
  case camera
  case files
}

class MediaPickerIntent: @unchecked Sendable {

  private weak var model: MediaPickerModelActionsProtocol?
  private weak var routeModel: MediaPickerModelRouterProtocol?
  private weak var moduleOutput: MediaPickerModuleOutput?
  var viewerModule: PhotoViewerModuleInput?
  private let photosLoader: PhotosLoader
  
  private var allAssets: [any PHMediaAsset] = []
  private var selectedPhotos: [any PHMediaAsset] = []
  

  init(
    model: (MediaPickerModelActionsProtocol & MediaPickerModelRouterProtocol)?,
    moduleOutput:MediaPickerModuleOutput?
  ) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.photosLoader = PhotosLoader()
  }
  
  private func getPhotosFromLibrary() async throws -> [any PHMediaAsset] {
    return try await photosLoader.getGalleryMediaAssets(direction: .older)
  }
  
}

// MARK: - MediaPickerIntentProtocol
extension MediaPickerIntent: MediaPickerIntentProtocol {
  func viewOnAppear() {
    Task {
      do {
        self.allAssets = try await self.getPhotosFromLibrary()
        self.model?.didLoadPhotosFromLibrary(self.allAssets)
      } catch {
        Log.custom(category: "MediaPickerIntent")
          .error("Error loading photos from library: \(error)")
      }
    }
  }
  
  func didSelectItem(_ item: PhotoDisplayItem) {
    selectedPhotos.append(item.asset)
    model?.didSelectItem(item)
  }
  
  func didTapOn(_ item: PhotoDisplayItem, namespace: Namespace.ID) {
    routeModel?.presentPhotoViewer(item, namespace: namespace)
  }
  
  func sendSelectedMedia() {
    Task {
      var photos = [UIImage]()
      let assets = selectedPhotos
        .compactMap({ $0 as? PHPhotoAsset })
      
      for asset in assets {
        let size = asset.originalSize
        let image = try await asset.requestImage(with: size)
        photos.append(image)
      }
      moduleOutput?.didSelectMedia(photos)
    }
    routeModel?.closeModule()
  }
  
  func didTapOn(buttonType: MediaButtonType) {
    moduleOutput?.didTapOn(buttonType: buttonType)
    routeModel?.closeModule()
  }
  
  func closeModule() {
    routeModel?.closeModule()
  }
}


// MARK: - MediaPickerModuleInput
extension MediaPickerIntent: MediaPickerModuleInput {
  
}

// MARK: - PhotoViewerModuleOutput
extension MediaPickerIntent: PhotoViewerModuleOutput {
  
}

