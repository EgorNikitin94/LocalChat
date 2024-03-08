//
//  DialogListRowViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/15/22.
//

import UIKit
import Observation

@Observable
class DialogListDisplayItem: Identifiable, Hashable, Equatable {
  let id: UUID
  var userName: String
  var lastMessageText: String?
  var lastMessageDate: String?
  var userAvatar: UIImage?
  var unreadCount: UInt
  var muted: Bool
  var pined: Bool
  var isUserOnline: Bool
  
  @ObservationIgnored var baseModel: Dialog
  
  init(dialog: Dialog) {
    self.id = dialog.id
    self.userName = dialog.user.name
    self.lastMessageText = dialog.lastMessage?.text
    self.lastMessageDate = TimeManagerHalper.makeString(from: dialog.lastMessage?.date)
    self.userAvatar = dialog.user.avatar
    self.unreadCount = dialog.unreadCount
    self.isUserOnline = dialog.user.isOnline
    self.muted = dialog.muted
    self.pined = dialog.pined
    self.baseModel = dialog
  }
  
  func update(with dialog: Dialog) {
    self.userName = dialog.user.name
    self.lastMessageText = dialog.lastMessage?.text
    self.lastMessageDate = TimeManagerHalper.makeString(from: dialog.lastMessage?.date)
    self.userAvatar = dialog.user.avatar
    self.unreadCount = dialog.unreadCount
    self.isUserOnline = dialog.user.isOnline
    self.muted = dialog.muted
    self.pined = dialog.pined
    self.baseModel = dialog
  }
  
  static func == (lhs: DialogListDisplayItem, rhs: DialogListDisplayItem) -> Bool {
    return lhs.id.uuidString == rhs.id.uuidString
  }
  
  func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
  
}
