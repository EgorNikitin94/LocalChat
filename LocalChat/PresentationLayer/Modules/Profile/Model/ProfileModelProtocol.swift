//
//  ProfileModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol ProfileModelActionsProtocol: AnyObject {
  func newEvent(_ event: ProfileEvent)
}

protocol ProfileModelStateProtocol {
  var sections: [ProfileSectionDisplayItem] { get }
  var routerSubject: ProfileRouter.Subjects { get }
}

// MARK: - Route
protocol ProfileModelRouterProtocol: AnyObject {
  
}
