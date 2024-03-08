//
//  DialogsListIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol DialogsListIntentProtocol: AnyObject {
  func viewOnAppear()
  func openConversation(for vm: DialogListDisplayItem)
  func openProfile()
  func search(with query: String)
}

@objc protocol DialogsListModuleInput: AnyObject {
  
}

@objc protocol DialogsListModuleOutput: AnyObject {
  
}
