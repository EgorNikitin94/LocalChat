//
//  DialogsListModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Combine

class DialogsListModel: ObservableObject, DialogsListModelStateProtocol {
  
  @Published var dialogs: [DialogListRowViewModel] = []
  @Published var searchText: String = ""
  @Published var isPresentedSearch: Bool = false
  
  let routerSubject = DialogsListRouter.Subjects()
}

// MARK: - Actions
extension DialogsListModel: DialogsListModelActionsProtocol {
  func didLoadDialogs(dialogs: [Dialog]) {
    self.dialogs = dialogs.map({ dialog in
      DialogListRowViewModel(dialog: dialog)
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
