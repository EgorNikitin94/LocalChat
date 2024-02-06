//
//  AuthModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol AuthModelActionsProtocol: AnyObject {
  func changeState(_ newState: AuthModel.State)
}

protocol AuthModelStateProtocol {
  var login: String { get set }
  var password: String { get set }
  var state: AuthModel.State { get }
  var routerSubject: AuthRouter.Subjects { get }
}

// MARK: - Route
protocol AuthModelRouterProtocol: AnyObject {
  func didTapSignIn()
}
