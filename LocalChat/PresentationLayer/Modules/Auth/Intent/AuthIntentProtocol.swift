//
//  AuthIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol AuthIntentProtocol: AnyObject {
  func viewOnAppear()
}

@objc protocol AuthModuleInput: AnyObject {
  
}

@objc protocol AuthModuleOutput: AnyObject {
  
}