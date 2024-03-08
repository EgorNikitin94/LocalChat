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
  func didUpdateDialog(_ dialog: Dialog)
}

protocol DialogsListModelStateProtocol {
  var dialogs: [DialogListDisplayItem] { get }
  var searchText: String { get set }
  var isPresentedSearch: Bool { get set }
  var routerSubject:DialogsListRouter.Subjects { get }
}

// MARK: - Route
protocol DialogsListModelRouterProtocol: AnyObject {
  func openConversation(for peer: User)
  func openProfile()
}
