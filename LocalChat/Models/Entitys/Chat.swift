//
//  Chat.swift
//  LocalChat
//
//  Created by Егор Никитин on 3/23/24.
//

import Foundation

struct Chat: Peer {
  let id: String
  let type: PeerType = .chat
}
