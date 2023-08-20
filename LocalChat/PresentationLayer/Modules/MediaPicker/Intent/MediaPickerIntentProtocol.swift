//
//  MediaPickerIntentProtocol.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import UIKit

protocol MediaPickerIntentProtocol: AnyObject {
  func viewOnAppear()
  func didSelectItem(_ item: PhotoDisplayItem)
  func sendSelectedMedia()
  func didTapOn(buttonType: MediaButtonType)
  func closeModule()
}

@objc protocol MediaPickerModuleInput: AnyObject {
  
}

@objc protocol MediaPickerModuleOutput: AnyObject {
  func didSelectMedia(_ media: [UIImage])
  func didTapOn(buttonType: MediaButtonType)
}
