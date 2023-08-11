//
//  ProfileIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol ProfileIntentProtocol: AnyObject {
  func viewOnAppear()
}

@objc protocol ProfileModuleInput: AnyObject {
  
}

@objc protocol ProfileModuleOutput: AnyObject {
  
}