// 
//  PhotoViewerIntentProtocol.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import Foundation

protocol PhotoViewerIntentProtocol: AnyObject {
  func viewOnAppear()
}

@objc protocol PhotoViewerModuleInput: AnyObject {
  
}

@objc protocol PhotoViewerModuleOutput: AnyObject {
  
}
