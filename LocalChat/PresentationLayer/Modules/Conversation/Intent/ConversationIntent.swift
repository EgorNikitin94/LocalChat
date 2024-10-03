//
//  ConversationIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit

class ConversationIntent: @unchecked Sendable {

  private weak var model: ConversationModelActionsProtocol?
  private weak var routeModel: ConversationModelRouterProtocol?
  private weak var moduleOutput: ConversationModuleOutput?
  
  private let messgeService: MessageServiceProtocol = MockMessageService()
  private let userService: UserServiceProtocol = MockUserService()
  
  private var peer: User
  private var realTimeMessages: [Message] = []

  init(
    peer: User,
    model: (ConversationModelActionsProtocol & ConversationModelRouterProtocol)?,
    moduleOutput: ConversationModuleOutput?
  ) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.peer = peer
  }
  
}

// MARK: - ConversationIntentProtocol
extension ConversationIntent: ConversationIntentProtocol {
  func viewOnAppear() {
    Task {
      await model?.configure(with: peer)
      realTimeMessages = messgeService.getMessages(for: peer, user: userService.currentUser)
      await model?.didLoad(messages: realTimeMessages)
    }
  }
  
  func sendMessage(with inputText: String) {
    let newMessage = Message(from: userService.currentUser, to: peer, date: Date(), text: inputText)
    realTimeMessages.append(newMessage)
    Task {
      await model?.didSendMessage(messsage: newMessage)
    }
  }
  
  func openMediaPicker() {
    routeModel?.openMediaPicker()
  }
  
  func onTestIncomeMessageEvent() {
    let newMessage = Message(from: peer, to: peer, date: Date(), text: "Some test message")
    realTimeMessages.append(newMessage)
    Task {
      await model?.didSendMessage(messsage: newMessage)
    }
  }
}


// MARK: - ConversationModuleInput
extension ConversationIntent: ConversationModuleInput {
  
}

// MARK: - MediaPickerModuleOutput
extension ConversationIntent: MediaPickerModuleOutput {
  func didSelectMedia(_ media: [UIImage]) {
    print("media select count == \(media.count)")
    var newMessage = Message(from: userService.currentUser, to: peer, date: Date(), text: "")
    newMessage.mediaData = media.first?.jpegData(compressionQuality: 1.0)
    realTimeMessages.append(newMessage)
    Task {
      await model?.didSendMessage(messsage: newMessage)
    }
  }
  
  func didTapOn(buttonType: MediaButtonType) {
    print("open \(buttonType)")
  }
}
