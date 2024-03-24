//
//  Chat.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/23/24.
//

import Foundation
import GRDB

struct Chat: Peer {
  let id: UUID
  var type: PeerType = .chat
  
  enum Columns: String, ColumnExpression {
    case id, type
  }
}
