//
//  ConversationViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI
import Combine

class ConversationViewModel: ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  @Published var realTimeMessages: [Message] = []
  @Published var inputText: String = ""
  @Published var hideSendButton: Bool = true
  var dialog: Dialog
  
  private let messgeService: MessageServiceProtocol
  
  private let userService: UserServiceProtocol
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init(dialog: Dialog, messgeService: MessageServiceProtocol, userService: UserServiceProtocol) {
    self.messgeService = messgeService
    self.userService = userService
    
    
    self.dialog = dialog
    realTimeMessages = messgeService.getMessages(for: dialog, user: userService.currentUser)
    
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
  
  func sendMessage() {
    let newMessage = Message(from: userService.currentUser, to: dialog.user, date: Date(), text: inputText)
    inputText = ""
    withAnimation {
      realTimeMessages.append(newMessage)
    }
    didChange.send(())
  }
}
