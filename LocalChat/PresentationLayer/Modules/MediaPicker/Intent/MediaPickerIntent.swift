//
//  MediaPickerIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit
import Photos

class MediaPickerIntent {

  private weak var model: MediaPickerModelActionsProtocol?
  private weak var routeModel: MediaPickerModelRouterProtocol?
  private weak var moduleOutput: MediaPickerModuleOutput?
  
  private var allPhotos: [UIImage] = []

  init(model: (MediaPickerModelActionsProtocol & MediaPickerModelRouterProtocol)?, moduleOutput:MediaPickerModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
  private func getPhotosFromLibrary() async -> [UIImage] {
    let manager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = false
    requestOptions.deliveryMode = .highQualityFormat
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    
    let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    
    var findedImages: [UIImage] = []
    
    for index in 0...results.count - 1 {
      let asset = results.object(at: index)
      let size = CGSize(width: 512, height: 512)
      let image = await withCheckedContinuation { continuation in
        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { image, info in
          if let image = image {
            continuation.resume(returning: image)
          } else {
            print("error asset to image")
          }
        }
      }
      findedImages.append(image)
    }
    
    return findedImages
  }
  
}

// MARK: - MediaPickerIntentProtocol
extension MediaPickerIntent: MediaPickerIntentProtocol {
  func viewOnAppear() {
    PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
      switch status {
      case .authorized:
        Task {
          self.allPhotos = await self.getPhotosFromLibrary()
          self.model?.didLoadPhotosFromLibrary(self.allPhotos)
        }
      case .limited, .denied, .restricted, .notDetermined:
        break
      @unknown default:
        break
      }
    }
  }
  
  func closeModule() {
    routeModel?.closeModule()
  }
}


// MARK: - MediaPickerModuleInput
extension MediaPickerIntent: MediaPickerModuleInput {
  
}

