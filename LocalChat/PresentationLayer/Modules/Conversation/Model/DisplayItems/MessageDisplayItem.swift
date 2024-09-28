//
//  MessageDisplayItem.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/12/23.
//

import SwiftUI
import Observation

enum MessageContentType {
  case text
  case image
}

@Observable
class MessageDisplayItem: Identifiable, Hashable, Equatable {
  @ObservationIgnored let id: UUID
  @ObservationIgnored let from: User
  @ObservationIgnored let to: User
  @ObservationIgnored var textContent: String
  @ObservationIgnored let dateText: String
  @ObservationIgnored var topDateCapsuleText: String?
  @ObservationIgnored var needShowTopDateCapsuleText: Bool = false
  @ObservationIgnored var media: UIImage? = nil
  var isEndOfSequence: Bool = false
  
  var attributedString: AttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
//                        NSAttributedString.Key.paragraphStyle: style,
                        NSAttributedString.Key.font: 16,
//                        NSAttributedString.Key.font: 34
                      ]
    let str = NSAttributedString(string: textContent, attributes: attributes)
    return AttributedString(str)
  }
  
  var isFromCurrentUser: Bool {
    from.isMe
  }
  
  var messageContentType: MessageContentType {
    if let _ = media {
      return .image
    } else {
      return .text
    }
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
    self.dateText = TimeManagerHalper.messageTime(from: message.date) ?? ""
    self.media = message.media
    
    self.topDateCapsuleText = TimeManagerHalper.messageTimeCapsuleTime(from: message.date) ?? ""
  }
  
  func isEqualSender(with previews: MessageDisplayItem) -> Bool {
    isFromCurrentUser == previews.isFromCurrentUser
  }
  
  func isEqualDate(with previews: MessageDisplayItem) -> Bool {
    topDateCapsuleText == previews.topDateCapsuleText
  }
}
