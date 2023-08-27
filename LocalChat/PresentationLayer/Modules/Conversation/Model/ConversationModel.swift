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
  @Published var avatarDisplayItem: AvatarDisplayItem?
  @Published var realTimeMessages: [MessageDisplayItem] = []
  @Published var isInitialState: Bool = true
  @Published var inputText: String = ""
  @Published var hideSendButton: Bool = true
  @Published var chatImage: UIImage?
  @Published var navTitle: String = ""
  @Published var onlineDate: String = ""
  @Published var isOnline: Bool = false
  
  let routerSubject = ConversationRouter.Subjects()
  
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
  
  private func prepareDisplayItems(_ displayItems: [MessageDisplayItem]) -> [MessageDisplayItem] {
    var isFromCurrent: Bool? = nil
    var dateString: String? = nil
    var array1: [MessageDisplayItem] = []
    var array: [MessageDisplayItem] = []
    let reversedDisplayItems = displayItems.reversed()
    for (index, item) in reversedDisplayItems.enumerated() {
      if item.topDateCapsuleText != dateString {
        dateString = item.topDateCapsuleText
        item.isEndOfSequence = true
        item.needShowTopDateCapsuleText = true
        if index > 1 {
          array1[index - 1].isEndOfSequence = true
        }
      }
      array1.append(item)
    }
    let reversedArray = array1.reversed()
    reversedArray.forEach { item in
      let itemForAdd = item
      if isFromCurrent == nil {
        isFromCurrent = item.isFromCurrentUser
        itemForAdd.isEndOfSequence = true
      }
      
      if isFromCurrent != itemForAdd.isFromCurrentUser {
        isFromCurrent = item.isFromCurrentUser
        itemForAdd.isEndOfSequence = true
      }
      
      array.append(itemForAdd)
    }
    return array
  }
}

// MARK: - Actions
extension ConversationModel: ConversationModelActionsProtocol {  
  func configure(with peer: User) {
    avatarDisplayItem = AvatarDisplayItem(with: peer)
    navTitle = peer.name
    isOnline = peer.isOnline
    if !isOnline {
      onlineDate = "был(а) вчера"
    }
  }
  
  func didLoad(messages: [Message]) {
    let displayItems = messages.reversed().map({ MessageDisplayItem(with: $0) })
    realTimeMessages = prepareDisplayItems(displayItems)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.isInitialState.toggle()
    }
  }
  
  func didSendMessage(messsage: Message) {
    defer {
      inputText = ""
    }
    withAnimation(.spring()) {
      let messageDisplayItem = MessageDisplayItem(with: messsage)
      if let previusFirst = realTimeMessages.first {
        if previusFirst.isFromCurrentUser == messageDisplayItem.isFromCurrentUser {
          previusFirst.isEndOfSequence = false
        } else if previusFirst.topDateCapsuleText != messageDisplayItem.topDateCapsuleText {
          messageDisplayItem.needShowTopDateCapsuleText = true
          if messageDisplayItem.isFromCurrentUser == previusFirst.isFromCurrentUser {
            previusFirst.isEndOfSequence = true
          }
        }
      }
      messageDisplayItem.isEndOfSequence = true
      realTimeMessages.insert(messageDisplayItem, at: 0)
    }
  }
}

// MARK: - Route
extension ConversationModel: ConversationModelRouterProtocol {
  func openMediaPicker() {
    routerSubject.screen.send(.mediaPicker)
  }
}
