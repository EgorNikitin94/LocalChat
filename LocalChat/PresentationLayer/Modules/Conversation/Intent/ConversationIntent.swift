//
//  ConversationIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class ConversationIntent {

  private weak var model: ConversationModelActionsProtocol?
  private weak var routeModel: ConversationModelRouterProtocol?
  private weak var moduleOutput: ConversationModuleOutput?
  
  private let messgeService: MessageServiceProtocol = MockMessageService()
  private let userService: UserServiceProtocol = MockUserService()
  
  private var peer: User
  private var realTimeMessages: [Message] = []

  init(peer: User, model: (ConversationModelActionsProtocol & ConversationModelRouterProtocol)?, moduleOutput: ConversationModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.peer = peer
  }
  
}

// MARK: - ConversationIntentProtocol
extension ConversationIntent: ConversationIntentProtocol {
  func viewOnAppear() {
    model?.configure(with: peer)
    realTimeMessages = messgeService.getMessages(for: peer, user: userService.currentUser)
    model?.didLoad(messages: realTimeMessages)
  }
  
  func sendMessage(with inputText: String) {
    let newMessage = Message(from: userService.currentUser, to: peer, date: Date(), text: inputText)
    realTimeMessages.append(newMessage)
    model?.didSendMessage(messsage: newMessage)
  }
  
  func openMediaPicker() {
    routeModel?.openMediaPicker()
  }
}


// MARK: - ConversationModuleInput
extension ConversationIntent: ConversationModuleInput {
  
}

// MARK: - MediaPickerModuleOutput
extension ConversationIntent: MediaPickerModuleOutput {
  
}
