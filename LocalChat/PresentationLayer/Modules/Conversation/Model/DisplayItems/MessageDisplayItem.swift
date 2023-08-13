//
//  MessageDisplayItem.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/12/23.
//

import SwiftUI
import Combine

class MessageDisplayItem: ObservableObject, Identifiable, Hashable, Equatable {
  let id: UUID
  let from: User
  let to: User
  var textContent: String
  let dateText: String
  @Published var isEndOfSequence: Bool = false
  
  var isFromCurrentUser: Bool {
    from.isCurrentUser
  }
  
  static func == (lhs: MessageDisplayItem, rhs: MessageDisplayItem) -> Bool {
    lhs.id == rhs.id && lhs.isEndOfSequence == rhs.isEndOfSequence
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  init(with message: Message) {
    self.id = message.id
    self.from = message.from
    self.to = message.to
    self.textContent = message.text
    self.dateText = TimeManagerHalper.makeString(from: message.date) ?? ""
  }
}
