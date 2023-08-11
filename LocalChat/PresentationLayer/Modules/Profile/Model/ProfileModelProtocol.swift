//
//  ProfileModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol ProfileModelActionsProtocol: AnyObject {
  
}

protocol ProfileModelStateProtocol {
  var routerSubject:ProfileRouter.Subjects { get }
}

// MARK: - Route
protocol ProfileModelRouterProtocol: AnyObject {
  
}