//
//  Peer.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/9/24.
//

import UIKit

enum PeerType: Codable {
  case user
  case chat
}

protocol Peer: SQLiteEntity {
  var id: UUID { get }
  var type: PeerType { get }
  var title: String { get }
  var avatar: UIImage?  { get }
}
