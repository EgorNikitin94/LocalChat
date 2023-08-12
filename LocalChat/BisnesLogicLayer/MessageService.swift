//
//  MessageService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import Foundation

protocol MessageServiceProtocol {
  func getMessages(for peer: User, user: User) -> [Message]
}

class MessageService {

}

class MockMessageService: MessageServiceProtocol {
  private var messages: [Message] = []
  
  func getMessages(for peer: User, user: User) -> [Message] {
    return [Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 40000), text: "Hallo there!"),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 30000), text: "Hi"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 20990), text: "Leverage programmatic control over your app’s navigation behavior to set its launch state, manage transitions between size classes, respond to deep links, and more."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10000), text: "Make your widgets look great on the Lock Screen with SwiftUI."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10000), text: "SwiftUI uses a declarative syntax, so you can simply state what your user interface should do."),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 7500), text: "Ok. Good"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 6500), text: "For example, you can write that you want a list of items consisting of text fields, then describe alignment, font, and color for each field. "),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Xcode includes intuitive design")]
  }
}
