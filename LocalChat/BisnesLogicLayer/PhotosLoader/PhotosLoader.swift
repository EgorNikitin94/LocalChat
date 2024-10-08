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

enum Direction {
  case older, newer
}

actor PhotosLoader {
  private let manager: PHImageManager
  private var offsetRange: ClosedRange<Date> = (.now)...(.now)
  
  init() {
    manager = .init()
  }
  
  func getGalleryMediaAssets(
    around date: Date,
    eachDirectionLimit: Int
  ) async throws -> [any PHMediaAsset] {
    async let older = try await getGalleryMediaAssets(
      direction: .older,
      limit: eachDirectionLimit
    )
    async let newer = try await getGalleryMediaAssets(
      direction: .newer,
      limit: eachDirectionLimit
    )
    return try await (newer + older)
  }
  
  func getGalleryMediaAssets(
    direction: Direction,
    limit: Int = 25
  ) async throws -> [any PHMediaAsset] {
    let result = try await getGalleryPHAssets(
      direction: direction,
      limit: limit
    )
    let mesiaAssets: [any PHMediaAsset] = result.compactMap {
      switch $0.mediaType {
      case .image:
        return PHPhotoAsset(with: $0)
      case .video:
        return PHVideoAsset(with: $0)
      default:
        return nil
      }
    }
    return mesiaAssets
  }
  
  private func getGalleryPHAssets(
    direction: Direction,
    limit: Int = 25
  ) async throws -> [PHAsset] {
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
      fetchOptions.predicate = switch direction {
      case .older:
        NSPredicate(
          format: "creationDate < %@",
          argumentArray: [offsetRange.lowerBound]
        )
      case .newer:
        NSPredicate(
          format: "creationDate > %@",
          argumentArray: [offsetRange.upperBound]
        )
      }
      fetchOptions.fetchLimit = limit
      
      let results: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
      
      var assets: [PHAsset] = []
      results.enumerateObjects { asset, index, ptr in
        assets.append(asset)
      }
      let newOffsetDate = switch direction {
      case .older:
        assets.last?.creationDate ?? .now
      case .newer:
        assets.first?.creationDate ?? .now
      }
        
      offsetRange = switch direction {
      case .older:
        newOffsetDate...offsetRange.upperBound
      case .newer:
        offsetRange.lowerBound...newOffsetDate
      }
      return assets
    case .limited, .denied, .restricted, .notDetermined:
      throw PhotosLoaderError.noAccess
    @unknown default:
      throw PhotosLoaderError.noAccess
    }
  }
}
