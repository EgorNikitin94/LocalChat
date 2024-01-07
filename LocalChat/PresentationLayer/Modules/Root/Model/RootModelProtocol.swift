// 
//  RootModelProtocol.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import Foundation

protocol RootModelActionsProtocol: AnyObject {
  func didChangeTabBarSelectedState(with type: RootViewTabItem.TabBarItemType)
}

protocol RootModelStateProtocol {
  var state: RootViewTabItem.TabBarItemType { get set }
  var tabBarItems: [RootViewTabItem] { get }
  var routerSubject:RootRouter.Subjects { get }
}

// MARK: - Route
protocol RootModelRouterProtocol: AnyObject {
  
}
