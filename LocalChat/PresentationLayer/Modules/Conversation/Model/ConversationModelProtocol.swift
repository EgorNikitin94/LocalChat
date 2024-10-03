//
//  ConversationModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

@MainActor
protocol ConversationModelActionsProtocol: AnyObject {
  func configure(with peer: User)
  func didLoad(messages: [Message])
  func didSendMessage(messsage: Message)
}

protocol ConversationModelStateProtocol {
  var routerSubject:ConversationRouter.Subjects { get }
  var realTimeMessages: [MessageDisplayItem] { get }
  var isInitialState: Bool { get }
  var navTitle: String { get }
  var onlineDate: String { get }
  var isOnline: Bool { get }
  var avatarDisplayItem: AvatarDisplayItem? { get }
  var inputText: String { get set }
  var hideSendButton: Bool { get }
}

// MARK: - Route
protocol ConversationModelRouterProtocol: AnyObject {
  func openMediaPicker()
}
