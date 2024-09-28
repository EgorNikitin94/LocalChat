//
//  ConversationModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Observation

@Observable 
final class ConversationModel: ConversationModelStateProtocol {
  var avatarDisplayItem: AvatarDisplayItem?
  var realTimeMessages: [MessageDisplayItem] = []
  var isInitialState: Bool = true
  var inputText: String = "" {
    didSet {
      hideSendButton = !(inputText.count > 0)
    }
  }
  var hideSendButton: Bool = true
  var chatImage: UIImage?
  var navTitle: String = ""
  var onlineDate: String = ""
  var isOnline: Bool = false
  
  let routerSubject = ConversationRouter.Subjects()
  
  init() {}
  
  private func prepareDisplayItems(_ displayItems: [MessageDisplayItem]) -> [MessageDisplayItem] {
    var array: [MessageDisplayItem] = []
    for (index, item) in displayItems.enumerated() {
      let previewsItem: MessageDisplayItem? = index + 1 > (0..<displayItems.count - 1).upperBound ? nil : displayItems[index + 1]
      let nextItem: MessageDisplayItem? = index - 1 < (0..<displayItems.count - 1).lowerBound ? nil : displayItems[index - 1]
      
      if let nextItem {
        item.isEndOfSequence = !item.isEqualSender(with: nextItem) || !item.isEqualDate(with: nextItem)
      } else {
        item.isEndOfSequence = true
      }
      
      if let previewsItem {
        item.needShowTopDateCapsuleText = !item.isEqualDate(with: previewsItem)
      } else {
        item.needShowTopDateCapsuleText = true
      }
      
      array.append(item)
    }
    return array
  }
}

// MARK: - Actions
extension ConversationModel: @preconcurrency ConversationModelActionsProtocol {  
  func configure(with peer: User) {
    avatarDisplayItem = AvatarDisplayItem(with: peer)
    navTitle = peer.name
    isOnline = peer.isOnline
    if !isOnline {
      onlineDate = String(localized: "was yesterday")
    }
  }
  
  @MainActor
  func didLoad(messages: [Message]) {
    let displayItems = messages.reversed().map({ MessageDisplayItem(with: $0) })
    realTimeMessages = prepareDisplayItems(displayItems)
    
    Task {
      try await Task.sleep(for: .microseconds(500))
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
