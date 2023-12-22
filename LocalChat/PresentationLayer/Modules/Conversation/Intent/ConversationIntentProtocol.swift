//
//  ConversationIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol ConversationIntentProtocol: AnyObject {
  func viewOnAppear()
  func sendMessage(with inputText: String)
  func openMediaPicker()
  func onTestIncomeMessageEvent()
}

@objc protocol ConversationModuleInput: AnyObject {

}

@objc protocol ConversationModuleOutput: AnyObject {
  
}
