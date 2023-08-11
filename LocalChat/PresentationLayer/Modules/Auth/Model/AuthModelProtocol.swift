//
//  AuthModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol AuthModelActionsProtocol: AnyObject {
  
}

protocol AuthModelStateProtocol {
  var routerSubject:AuthRouter.Subjects { get }
}

// MARK: - Route
protocol AuthModelRouterProtocol: AnyObject {
  
}