//
//  DialogListRowViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/15/22.
//

import UIKit

struct DialogListRowViewModel: Identifiable, Hashable {
  let id: UUID
  let userName: String
  let lastMessageText: String?
  let lastMessageDate: String?
  let userAvatar: UIImage?
  let unreadCount: Int
  let isUserOnline: Bool
  
  let baseModel: Dialog
  
  init(dialog: Dialog) {
    self.id = dialog.id
    self.userName = dialog.user.name
    self.lastMessageText = dialog.lastMessage?.text
    self.lastMessageDate = TimeManagerHalper.makeString(from: dialog.lastMessage?.date)
    self.userAvatar = dialog.user.avatar
    self.unreadCount = dialog.unreadCount
    self.isUserOnline = dialog.user.isOnline
    self.baseModel = dialog
  }
  
  static func == (lhs: DialogListRowViewModel, rhs: DialogListRowViewModel) -> Bool {
    return lhs.id.uuidString == rhs.id.uuidString
  }
  
  func hash(into hasher: inout Hasher) {
       hasher.combine(id)
   }
  
}
