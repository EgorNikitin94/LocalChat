//
//  DialogsListModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol DialogsListModelActionsProtocol: AnyObject {
  func didLoadDialogs(dialogs: [Dialog])
}

protocol DialogsListModelStateProtocol {
  var dialogs: [DialogListRowViewModel] { get }
  var routerSubject:DialogsListRouter.Subjects { get }
}

// MARK: - Route
protocol DialogsListModelRouterProtocol: AnyObject {
  func openConversation(for peer: User)
  func openProfile()
}