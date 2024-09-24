//
//  Dialog.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation
@preconcurrency import GRDB

struct Dialog {
  var id: UUID
  let peer: User
  let peerType: PeerType
  let lastMessage: Message?
  var unreadCount: UInt = 0
  var muted: Bool = false
  var pined: Bool = false
  
  init(
    peer: User,
    lastMessage: Message?,
    unreadCount: UInt = 0,
    muted: Bool = false,
    pined: Bool = false
  ) {
    self.id = peer.id
    self.peerType = peer.type
    self.peer = peer
    self.lastMessage = lastMessage
    self.unreadCount = unreadCount
    self.muted = muted
    self.pined = pined
  }
}

extension Dialog: SQLiteEntity {
  enum Columns: String, ColumnExpression {
    case id, peer, peerType, lastMessage, unreadCount, muted, pined
  }
  
  static let databaseTableName: String = "dialog"
  
  static let user = belongsTo(User.self)
  static let chat = belongsTo(Chat.self)
  
  static let lastMessage = belongsTo(Message.self)
}


struct DialogInfo: SQLiteEntity {
  enum DialogInfoPeer: Codable {
    case user(User)
    case chat(Chat)
  }
  let id: UUID
  let peer: DialogInfoPeer
  let lastMessage: Message
  var unreadCount: UInt = 0
  var muted: Bool = false
  var pined: Bool = false
}
