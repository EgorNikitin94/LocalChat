//
//  ConversationModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Combine

class ConversationModel: ObservableObject, ConversationModelStateProtocol {
  let routerSubject = ConversationRouter.Subjects()
  
  @Published var realTimeMessages: [Message] = []
  @Published var inputText: String = ""
  @Published var hideSendButton: Bool = true
  @Published var navTitle: String = ""
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    isShowSendButtonPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.hideSendButton, on: self)
      .store(in: &cancellableSet)
  }
  
  private var isShowSendButtonPublisher: AnyPublisher<Bool, Never> {
    $inputText
      .debounce(for: 0.1, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
        return !(input.count > 0)
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - Actions
extension ConversationModel: ConversationModelActionsProtocol {  
  func configure(with peer: User) {
    navTitle = peer.name
  }
  
  func didLoad(messages: [Message]) {
    realTimeMessages = messages.reversed()
  }
  
  func didSendMessage(messsage: Message) {
    defer {
      inputText = ""
    }
    withAnimation(.spring()) {
      realTimeMessages.insert(messsage, at: 0)
    }
  }
}

// MARK: - Route
extension ConversationModel: ConversationModelRouterProtocol {
  
}
