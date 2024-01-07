// 
//  RootModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import UIKit
import Combine

class RootViewTabItem: ObservableObject, Identifiable {
  let id: Int
  let tabBarType: TabBarItemType
  let title: String
  let imageName: String
  @Published var animationTrigger: Bool = false
  
  enum TabBarItemType: Int {
    case contacts
    case chats
    case profile
  }
  
  init(type: TabBarItemType) {
    self.id = type.rawValue
    self.tabBarType = type
    self.title = if type == .contacts {
      "Contacts"
    } else if type == .chats {
      "Chats"
    } else {
      "Settings"
    }
    
    self.imageName = if type == .contacts {
      "person.fill"
    } else if type == .chats {
      "message.fill"
    } else {
      "gear"
    }
  }
}

class RootModel: ObservableObject, RootModelStateProtocol {
  @Published var state: RootViewTabItem.TabBarItemType = .chats
  @Published var tabBarItems: [RootViewTabItem] = [
    RootViewTabItem(type: .contacts),
    RootViewTabItem(type: .chats),
    RootViewTabItem(type: .profile)
  ]
  
  private let orientationHasChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
  
  let routerSubject = RootRouter.Subjects()
}

// MARK: - Actions
extension RootModel: RootModelActionsProtocol {
  func didChangeTabBarSelectedState(with type: RootViewTabItem.TabBarItemType) {
    state = type
    tabBarItems.first(where: { $0.tabBarType == type })?.animationTrigger.toggle()
  }
}

// MARK: - Route
extension RootModel: RootModelRouterProtocol {
  
}
