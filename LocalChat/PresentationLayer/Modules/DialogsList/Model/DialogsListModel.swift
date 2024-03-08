//
//  DialogsListModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Observation

@Observable
class DialogsListModel: DialogsListModelStateProtocol {
  
  var dialogs: [DialogListDisplayItem] = []
  var searchText: String = ""
  var isPresentedSearch: Bool = false
  
  let routerSubject = DialogsListRouter.Subjects()
}

// MARK: - Actions
extension DialogsListModel: DialogsListModelActionsProtocol {
  func didLoadDialogs(dialogs: [Dialog]) {
    self.dialogs = dialogs.map({ dialog in
      DialogListDisplayItem(dialog: dialog)
    })
  }
}

// MARK: - Route
extension DialogsListModel: DialogsListModelRouterProtocol {
  func openConversation(for peer: User) {
    routerSubject.screen.send(.conversation(peer: peer))
  }
  
  func openProfile() {
    routerSubject.screen.send(.profile)
  }
}
