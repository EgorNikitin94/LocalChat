//
//  Message.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/5/24.
//

import UIKit
import GRDB

struct Message: Identifiable, Hashable, Equatable {
  static func == (lhs: Message, rhs: Message) -> Bool {
    lhs.id == rhs.id
  }
  
  var id: UUID = UUID()
  let from: User
  let to: User
  let date: Date
  let text: String
  var mediaData: Data? = nil
  
  var media: UIImage? {
    guard let mediaData = mediaData else {
      return nil
    }
    return UIImage(data: mediaData)
  }
}

extension Message: SQLiteEntity {
  enum Columns: String, ColumnExpression {
    case id, from, to, date, text, mediaData
  }
  
  static var databaseTableName: String = "message"
  
  static let from = belongsTo(User.self)
  static let to = belongsTo(User.self)
}
