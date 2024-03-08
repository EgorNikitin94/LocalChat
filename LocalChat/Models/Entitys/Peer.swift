//
//  Peer.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/9/24.
//

import Foundation

enum PeerType {
  case user
  case chat
}

protocol Peer {
  var id: String { get }
  var type: PeerType { get }
}
