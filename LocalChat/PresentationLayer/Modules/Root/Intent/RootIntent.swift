// 
//  RootIntent.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import Foundation

class RootIntent {
  
  private weak var model: RootModelActionsProtocol?
  private weak var routeModel: RootModelRouterProtocol?
  private weak var moduleOutput: RootModuleOutput?
  
  var dialigsListInput: DialogsListModuleInput?
  var profileModuleInput: ProfileModuleInput?
  
  init(model: (RootModelActionsProtocol & RootModelRouterProtocol)?, moduleOutput:RootModuleOutput?) {
    self.model = model
    self.routeModel = model
    self.moduleOutput = moduleOutput
  }
  
}

// MARK: - RootIntentProtocol
extension RootIntent: RootIntentProtocol {
  func viewOnAppear() {
    //
  }
  
  func didTapOnTabBarItem(with type: RootViewTabItem.TabBarItemType) {
    model?.didChangeTabBarSelectedState(with: type)
  }
}


// MARK: - RootModuleInput
extension RootIntent: RootModuleInput {
  
}

// MARK: - DialogsListModuleOutput
extension RootIntent: DialogsListModuleOutput {
  
}

// MARK: - ProfileModuleOutput
extension RootIntent: ProfileModuleOutput {
  
}
