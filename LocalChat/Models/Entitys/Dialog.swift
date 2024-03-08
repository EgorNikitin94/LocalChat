//
//  Dialog.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import Foundation

struct Dialog {
  let id: UUID = UUID()
  let user: User
  let lastMessage: Message?
  var unreadCount: UInt = 0
  var muted: Bool = false
  var pined: Bool = false
}
