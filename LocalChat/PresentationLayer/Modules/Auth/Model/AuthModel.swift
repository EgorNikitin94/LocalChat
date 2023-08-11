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
  let routerSubject = AuthRouter.Subjects()
}

// MARK: - Actions
extension AuthModel: AuthModelActionsProtocol {
  
}

// MARK: - Route
extension AuthModel: AuthModelRouterProtocol {
  
}