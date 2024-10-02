//
//  PhotosLoader.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/2/24.
//

import Foundation
import Photos

enum PhotosLoaderError: Error {
  case noAccess
  case noImages
}

actor PhotosLoader {
  
  let manager: PHImageManager
  
  init() {
    manager = .init()
  }
  
  func getGalleryPHAssets(
    with offsetDate: Date = .now,
    limit: Int = 25
  ) async throws -> ([PHAsset], nextOffset: Date) {
    let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
    switch status {
    case .authorized:
      let requestOptions = PHImageRequestOptions()
      requestOptions.isSynchronous = false
      requestOptions.deliveryMode = .highQualityFormat
      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(
        key: "creationDate",
        ascending: false
      )]
      fetchOptions.predicate = NSPredicate(
        format: "creationDate < %@",
        [offsetDate]
      )
      fetchOptions.fetchLimit = limit
      
      let results: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
      
      var assets: [PHAsset] = []
      results.enumerateObjects { asset, index, ptr in
        assets.append(asset)
      }
      let newOffsetDate = assets.last?.creationDate ?? .now
      return (assets, newOffsetDate)
    case .limited, .denied, .restricted, .notDetermined:
      throw PhotosLoaderError.noAccess
    @unknown default:
      throw PhotosLoaderError.noAccess
    }
  }
}
