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
}

class MockDialogsService: DialogsServiceProtocol {
  let tag: ServiceTag = .dialog
  private(set) var models: [Dialog] = []
    
  func getDialogsList() -> [Dialog] {
    var dialogs = [Dialog]()
    let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
    let user1 = User(type: .anotherUser, name: "John Poster", passsword: "1123", avatar: UIImage(named: "mock_1"), isOnline: true)
    var dialog1 = Dialog(user: user1, lastMessage: Message(from: user1, to: me, date: Date(), text: "Hallo! Whats the problem?"))
    dialog1.unreadCount = 10
    dialogs.append(dialog1)
    
    let user2 = User(type: .anotherUser, name: "Bob Robins", passsword: "1123", avatar: nil, isOnline: false)
    var dialog2 = Dialog(user: user2, lastMessage: Message(from: user2, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600), text: "OK"))
    dialog2.unreadCount = 2
    dialogs.append(dialog2)
    
    let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
    dialogs.append(Dialog(user: user3, lastMessage: Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "Sorry!")))
    
    let user4 = User(type: .anotherUser, name: "Rob Stark", passsword: "1123", avatar: UIImage(named: "mock_3"), isOnline: true)
    dialogs.append(Dialog(user: user4, lastMessage: Message(from: user4, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 24), text: "Please check your code now. I write on Swift ans its super")))
    
    let user5 = User(type: .anotherUser, name: "Jim Bim", passsword: "1123", avatar: nil, isOnline: false)
    dialogs.append(Dialog(user: user5, lastMessage: Message(from: user5, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 365), text: "Don't say again")))
    
    let user6 = User(type: .anotherUser, name: "Antony Blinkin", passsword: "1123", avatar: nil, isOnline: true)
    dialogs.append(Dialog(user: user6, lastMessage: Message(from: me, to: user6, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 1000), text: "Call me letter")))
    
    let user7 = User(type: .anotherUser, name: "Vladimir Rezanov", passsword: "1123", avatar: nil, isOnline: true)
    dialogs.append(Dialog(user: user7, lastMessage: nil))
    models = dialogs
    
    return models
  }
}
