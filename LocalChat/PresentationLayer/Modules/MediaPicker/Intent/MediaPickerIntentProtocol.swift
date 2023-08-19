//
//  MediaPickerIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation

protocol MediaPickerIntentProtocol: AnyObject {
  func viewOnAppear()
  func didSelectItem(_ item: PhotoDisplayItem)
  func closeModule()
}

@objc protocol MediaPickerModuleInput: AnyObject {
  
}

@objc protocol MediaPickerModuleOutput: AnyObject {
  
}
