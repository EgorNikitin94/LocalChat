//
//  ConversationViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import UIKit
import Combine

class ConversationViewModel: ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  @Published var realTimeMessages: [Message] = []
  @Published var inputText: String = ""
  @Published var hideSendButton: Bool = true
  var mockData: MockDataSourse
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init(user: User) {
    mockData = MockDataSourse()
    mockData.toUser = user
    mockData.messages = [
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Hallo there!"),
      Message(from: mockData.selfUser, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Hi"),
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Leverage programmatic control over your app’s navigation behavior to set its launch state, manage transitions between size classes, respond to deep links, and more."),
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Make your widgets look great on the Lock Screen with SwiftUI."),
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "SwiftUI uses a declarative syntax, so you can simply state what your user interface should do."),
      Message(from: mockData.selfUser, to: user, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Ok. Good"),
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "For example, you can write that you want a list of items consisting of text fields, then describe alignment, font, and color for each field. "),
      Message(from: user, to: mockData.selfUser, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "Xcode includes intuitive design"),
    ]
    realTimeMessages = mockData.messages
    
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
    let newMessage = Message(from: mockData.selfUser, to: mockData.toUser, date: Date(), text: inputText)
    inputText = ""
    realTimeMessages.append(newMessage)
    didChange.send(())
  }
}


struct MockDataSourse {
   let selfUser: User = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
   var toUser: User = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
   var messages: [Message] = []
}
