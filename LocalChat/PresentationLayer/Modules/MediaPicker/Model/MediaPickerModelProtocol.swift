//
//  MediaPickerModelProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol MediaPickerModelActionsProtocol: AnyObject {
  
}

protocol MediaPickerModelStateProtocol {
  var routerSubject:MediaPickerRouter.Subjects { get }
}

// MARK: - Route
protocol MediaPickerModelRouterProtocol: AnyObject {
  
}