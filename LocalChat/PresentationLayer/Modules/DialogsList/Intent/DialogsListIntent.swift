//
//  DialogsListIntent.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

class DialogsListIntent {

  private weak var model:DialogsListModelActionsProtocol?
  private weak var routeModel:DialogsListModelRouterProtocol?
  private weak var moduleOutput:DialogsListModuleOutput?
  
  private var dialogsService: DialogsServiceProtocol
  
  private var dialogs: [Dialog] = []

  init(
    model: (DialogsListModelActionsProtocol & DialogsListModelRouterProtocol)?,
    moduleOutput:DialogsListModuleOutput?,
    dialogService: DialogsServiceProtocol
  ) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
    self.dialogsService = dialogService
  }
  
}

// MARK: - DialogsListIntentProtocol
extension DialogsListIntent: DialogsListIntentProtocol {
  func viewOnAppear() {
    dialogs = dialogsService.getDialogsList()
    model?.didLoadDialogs(dialogs: dialogs)
  }
  
  func openConversation(for vm: DialogListRowViewModel) {
    if let user = dialogs
      .first(where: { $0.id == vm.id })
      .map({ $0.user }) {
      routeModel?.openConversation(for: user)
    }
  }
  
  func search(with query: String) {
    guard !query.isEmpty else {
      model?.didLoadDialogs(dialogs: dialogs)
      return
    }
    let searchDialogs = dialogs.filter({ $0.user.name.contains(query) })
    model?.didLoadDialogs(dialogs: searchDialogs)
  }
  
  func openProfile() {
    routeModel?.openProfile()
  }
}


// MARK: - DialogsListModuleInput
extension DialogsListIntent: DialogsListModuleInput {
  
}
