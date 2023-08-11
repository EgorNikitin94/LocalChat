//
//  ProfileModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Combine

class ProfileModel: ObservableObject, ProfileModelStateProtocol {
  let routerSubject = ProfileRouter.Subjects()
}

// MARK: - Actions
extension ProfileModel: ProfileModelActionsProtocol {
  
}

// MARK: - Route
extension ProfileModel: ProfileModelRouterProtocol {
  
}