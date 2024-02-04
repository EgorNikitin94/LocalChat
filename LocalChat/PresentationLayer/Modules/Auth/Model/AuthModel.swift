//
//  AuthModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Combine

class AuthModel: ObservableObject, AuthModelStateProtocol {
  @Published var login: String = ""
  @Published var password: String = ""
  @Published var passwordFieldEnabled = false
  @Published var buttonEnabled = false
  let routerSubject = AuthRouter.Subjects()
}

// MARK: - Actions
extension AuthModel: AuthModelActionsProtocol {
  
}

// MARK: - Route
extension AuthModel: AuthModelRouterProtocol {
  
}
