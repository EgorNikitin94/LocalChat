// 
//  RootModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import UIKit
import Observation

@Observable
class RootViewTabItem: Identifiable {
  @ObservationIgnored let id: Int
  @ObservationIgnored let tabBarType: TabBarItemType
  @ObservationIgnored let title: String
  @ObservationIgnored let imageName: String
  var animationTrigger: Bool = false
  
  enum TabBarItemType: Int {
    case contacts
    case chats
    case profile
  }
  
  init(type: TabBarItemType) {
    self.id = type.rawValue
    self.tabBarType = type
    self.title = if type == .contacts {
      String(localized: "Contacts")
    } else if type == .chats {
      String(localized: "Chats")
    } else {
      String(localized: "Settings")
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

@Observable
class RootModel: RootModelStateProtocol {
  var state: RootViewTabItem.TabBarItemType = .chats
  var tabBarItems: [RootViewTabItem] = [
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
