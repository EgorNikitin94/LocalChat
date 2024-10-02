//
//  MediaAsset.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/2/24.
//

import UIKit

enum MediaType {
  case image, video
}

protocol MediaAsset: Identifiable {
  associatedtype Source
  var id: UUID { get }
  var name: String { get }
  var mediaType: MediaType { get }
  var source: Source { get }
  var createdAt: Date? { get }
}
