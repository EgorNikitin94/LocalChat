//
//  PHPhotoRequestError.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/2/24.
//

import UIKit
import Photos

enum PHMediaAssetError: Error {
  case noImage
  case noVideo
}

protocol PHMediaAsset: Sendable, Identifiable, MediaAsset where Source == PHAsset {
  init(with source: Source)
  func requestImage(with targetSize: CGSize) async throws(PHMediaAssetError) -> UIImage
}

extension PHMediaAsset {
  func requestImage(with targetSize: CGSize) async throws(PHMediaAssetError) -> UIImage {
    let manager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = false
    requestOptions.deliveryMode = .highQualityFormat
    do {
      let image = try await withUnsafeThrowingContinuation { continuation in
        manager.requestImage(
          for: source,
          targetSize: targetSize,
          contentMode: .aspectFill,
          options: requestOptions
        ) { image, info in
          if let image = image {
            continuation.resume(returning: image)
          } else {
            continuation.resume(throwing: PHMediaAssetError.noImage)
          }
        }
      }
      return image
    } catch {
      throw .noImage
    }
  }
}

struct PHPhotoAsset: PHMediaAsset {
  let id: UUID
  let name: String
  let mediaType: MediaType = .image
  let source: PHAsset
  let createdAt: Date?
  
  let originalSize: CGSize
  
  init(with source: Source) {
    self.id = .init()
    self.name = source.localIdentifier
    self.source = source
    self.createdAt = source.creationDate
    
    let pixelWidth = source.pixelWidth
    let pixelHeight = source.pixelHeight
    self.originalSize = CGSize(width: pixelWidth, height: pixelHeight)
  }
}

enum PHVideoRequestError: Error {
  case noVideo
}

struct PHVideoAsset: PHMediaAsset {
  let id: UUID
  let name: String
  let mediaType: MediaType = .video
  let duration: TimeInterval
  let source: PHAsset
  let createdAt: Date?
  
  let originalSize: CGSize
  
  init(with source: Source) {
    self.id = .init()
    self.name = source.localIdentifier
    self.source = source
    self.createdAt = source.creationDate
    
    let pixelWidth = source.pixelWidth
    let pixelHeight = source.pixelHeight
    self.originalSize = CGSize(width: pixelWidth, height: pixelHeight)
    self.duration = source.duration
  }
}
