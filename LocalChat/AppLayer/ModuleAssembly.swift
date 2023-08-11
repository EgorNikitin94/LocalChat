//
//  ServiceAssemble.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/22/22.
//

import Foundation

let moduleAssembly: ModileAssembly = ModuleAssemblyImp()

fileprivate final class ServiceAssebly {
  
  fileprivate lazy var authService: AuthServiceProtocol = {
    MockAuthService()
  }()
  
  fileprivate lazy var userService: UserServiceProtocol = {
    MockUserService()
  }()
  
  fileprivate lazy var dialogService: DialogsServiceProtocol = {
    MockDialogsService()
  }()
  
  fileprivate lazy var messageService: MessageServiceProtocol = {
    MockMessageService()
  }()
  
}

protocol ModileAssembly {
  func assemblyAuth() -> AuthView
  func assemblyDialogsList() -> DialogsListView
  func assemblyConversation(for dialog: Dialog) -> ConversationView
  func assemblyProfile() -> ProfileView
}

final class ModuleAssemblyImp: ModileAssembly {
  
  fileprivate let serviceAssembly: ServiceAssebly = ServiceAssebly()
  
  fileprivate init() {}
  
  func assemblyAuth() -> AuthView {
    let vm = AuthViewModel(service: serviceAssembly.authService)
    return AuthView(viewModel: vm)
  }
  
  func assemblyDialogsList() -> DialogsListView {
    let vm = DialogsListViewModel(service: serviceAssembly.dialogService)
    return DialogsListView(viewModel: vm)
  }
  
  func assemblyConversation(for dialog: Dialog) -> ConversationView {
    return ConversationAssembly().build(dialog: dialog, moduleOutput: nil, completion: nil) as! ConversationView
  }
  
  func assemblyProfile() -> ProfileView {
    return ProfileView()
  }
  
  
}

