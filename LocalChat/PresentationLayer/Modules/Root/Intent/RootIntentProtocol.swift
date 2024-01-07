// 
//  RootIntentProtocol.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import Foundation

protocol RootIntentProtocol: AnyObject {
  func viewOnAppear()
  func didTapOnTabBarItem(with type: RootViewTabItem.TabBarItemType)
}

@objc protocol RootModuleInput: AnyObject {
  
}

@objc protocol RootModuleOutput: AnyObject {
  
}
