//
//  MessageService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import Foundation
import DataStructures

protocol MessageServiceProtocol {
  func getMessages(for peer: User, user: User) -> [Message]
}

class MessageService: AbstractService {

}

class MockMessageService: MessageServiceProtocol {
  private var messages: [Message] = []
  
  func getMessages(for peer: User, user: User) -> [Message] {
    return [Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 378600), text: "Hi, tell me about swift"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 355600), text: "The powerful programming language that’s also easy to learn"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 345600), text: "Swift is a powerful and intuitive programming language for all Apple platforms. It’s easy to get started using Swift, with a concise-yet-expressive syntax and modern features you’ll love. Swift code is safe by design and produces software that runs lightning-fast"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 299200), text: "Swift is the result of the latest research on programming languages, combined with decades of experience building Apple platforms."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 280200), text: "Named parameters are expressed in a clean syntax that makes APIs in Swift even easier to read and maintain"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 270200), text: "Even better, you don’t even need to type semi-colons. Inferred types make code cleaner and less prone to mistakes, while modules eliminate headers and provide namespaces"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 259200), text: "To best support international languages and emoji, strings are Unicode-correct and use a UTF-8-based encoding to optimize performance for a wide variety of use cases. Memory is managed automatically using tight, deterministic reference counting, keeping memory usage to a minimum without the overhead of garbage collection"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 259000), text: "You can even write concurrent code with simple, built-in keywords that define asynchronous behavior, making your code more readable and less error prone"),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 190800), text: "Okey, thanks"),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 178800), text: "Tell me about UIKit"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 175800), text: "UIKit provides a variety of features for building apps, including components you can use to construct the core infrastructure of your iOS, iPadOS, or tvOS apps."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 173800), text: "The framework provides the window and view architecture for implementing your UI, the event-handling infrastructure for delivering Multi-Touch and other types of input to your app, and the main run loop for managing interactions between the user, the system, and your app"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 172800), text: "UIKit also includes support for animations, documents, drawing and printing, text management and display, search, app extensions, resource management, and getting information about the current device"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400), text: "You can also customize accessibility support, and localize your app’s interface for different languages, countries, or cultural regions"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400), text: "UIKit works seamlessly with the SwiftUI framework, so you can implement parts of your UIKit app in SwiftUI or mix interface elements between the two frameworks"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400), text: "For example, you can place UIKit views and view controllers inside SwiftUI views, and vice versa"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400), text: "Important"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400), text: "Use UIKit classes only from your app’s main thread or main dispatch queue, unless otherwise indicated in the documentation for those classes"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 40000), text: "Hallo there!"),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 30000), text: "Hi, there"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 20990), text: "Leverage programmatic control over your app’s navigation behavior to set its launch state, manage transitions between size classes, respond to deep links, and more."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10000), text: "Make your widgets look great on the Lock Screen with SwiftUI."),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10000), text: "SwiftUI uses a declarative syntax, so you can simply state what your user interface should do."),
            Message(from: user, to: peer, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 7500), text: "Ok. Good"),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 6500), text: "For example, you can write that you want a list of items consisting of text fields, then describe alignment, font, and color for each field. "),
            Message(from: peer, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Xcode includes intuitive design")]
  }
}
