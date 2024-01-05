//
//  Message.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import UIKit

struct Message: Identifiable, Hashable, Equatable {
  static func == (lhs: Message, rhs: Message) -> Bool {
    lhs.id == rhs.id
  }
  
  let id: UUID = UUID()
  let from: User
  let to: User
  let date: Date
  let text: String
  var media: UIImage? = nil
}
