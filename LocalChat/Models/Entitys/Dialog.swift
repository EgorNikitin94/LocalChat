//
//  Dialog.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation
import GRDB

struct Dialog {
  var id: UUID = UUID()
  let peer: User
  let peerId: UUID
  let peerType: PeerType
  let lastMessage: Message?
  var unreadCount: UInt = 0
  var muted: Bool = false
  var pined: Bool = false
  
  init(
    id: UUID,
    peer: User,
    lastMessage: Message?,
    unreadCount: UInt = 0,
    muted: Bool = false,
    pined: Bool = false
  ) {
    self.id = id
    self.peer = peer
    self.peerId = peer.id
    self.peerType = peer.type
    self.lastMessage = lastMessage
    self.unreadCount = unreadCount
    self.muted = muted
    self.pined = pined
  }
}

extension Dialog: SQLiteEntity {
  enum Columns: String, ColumnExpression {
    case id, peer, peerId, peerType, lastMessage, unreadCount, muted, pined
  }
  
  static var databaseTableName: String = "dialog"
  
  static let user = hasOne(User.self)
  static let chat = hasOne(Chat.self)
}
