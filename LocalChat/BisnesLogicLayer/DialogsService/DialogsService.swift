//
//  DialogsService.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import UIKit
import Combine

protocol DialogsServiceProtocol: Service {
  var models: [Dialog] { get }
  func getDialogsList() -> [Dialog]
}

class DialogsService: DialogsServiceProtocol {
  var tag: ServiceTag = .dialog
  
  private(set) var models: [Dialog] = []
  
  func getDialogsList() -> [Dialog] {
    return []
  }
  
  func getDialogsFromDB() async -> [DialogInfo] {
    let request = Dialog
      .all()
      .including(required: Dialog.lastMessage)
      .including(required: Dialog.user)
      .asRequest(of: DialogInfo.self)
    let dialogs = try? await SQLiteStore.shared.fetch(request: request)
    return dialogs ?? []
  }
}

class MockDialogsService: DialogsServiceProtocol {
  let tag: ServiceTag = .dialog
  private(set) var models: [Dialog] = []
    
  func getDialogsList() -> [Dialog] {
    var dialogs = [Dialog]()
    let me = User(userType: .selfUser, name: "Mike", phone: "123", avatarTitle: "Me", isOnline: true)
    let user1 = User(userType: .anotherUser, name: "John Poster", phone: "1123", avatarTitle: "mock_1", isOnline: true)
    var dialog1 = Dialog(peer: user1, lastMessage: Message(from: user1, to: me, date: Date(), text: "Hallo! Whats the problem?"))
    dialog1.unreadCount = 10
    dialogs.append(dialog1)
    
    let user2 = User(userType: .anotherUser, name: "Bob Robins", phone: "1123", avatarTitle: nil, isOnline: false)
    var dialog2 = Dialog(peer: user2, lastMessage: Message(from: user2, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "OK"), muted: true)
    dialog2.unreadCount = 2
    dialogs.append(dialog2)
    
    let user3 = User(userType: .anotherUser, name: "Sarra Bold", phone: "1123", avatarTitle: "mock_2", isOnline: false)
    dialogs.append(Dialog(peer: user3, lastMessage: Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "Sorry!")))
    
    let user4 = User(userType: .anotherUser, name: "Rob Stark", phone: "1123", avatarTitle: "mock_3", isOnline: true)
    dialogs.append(Dialog(peer: user4, lastMessage: Message(from: user4, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 24), text: "Please check your code now. I write on Swift ans its super")))
    
    let user5 = User(userType: .anotherUser, name: "Jim Bim", phone: "1123", avatarTitle: nil, isOnline: false)
    dialogs.append(Dialog(peer: user5, lastMessage: Message(from: user5, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 365), text: "Don't say again")))
    
    let user6 = User(userType: .anotherUser, name: "Antony Blinkin", phone: "1123", avatarTitle: nil, isOnline: true)
    dialogs.append(Dialog(peer: user6, lastMessage: Message(from: me, to: user6, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 1000), text: "Call me letter")))
    
    let user7 = User(userType: .anotherUser, name: "Vladimir Rezanov", phone: "1123", avatarTitle: nil, isOnline: true)
    dialogs.append(Dialog(peer: user7, lastMessage: nil))
    models = dialogs
    
    return models
  }
}
