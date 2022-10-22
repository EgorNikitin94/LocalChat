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
  func assemblyAuth() -> LogInView
  func assemblyDialogsList() -> DialogsListView
  func assemblyConversation(for dialog: Dialog) -> ConversationView
  func assemblyProfile() -> ProfileView
}

final class ModuleAssemblyImp: ModileAssembly {
  
  fileprivate let serviceAssembly: ServiceAssebly = ServiceAssebly()
  
  fileprivate init() {}
  
  func assemblyAuth() -> LogInView {
    let vm = LogInViewModel(service: serviceAssembly.authService)
    return LogInView(viewModel: vm)
  }
  
  func assemblyDialogsList() -> DialogsListView {
    let vm = DialogsListViewModel(service: serviceAssembly.dialogService)
    return DialogsListView(viewModel: vm)
  }
  
  func assemblyConversation(for dialog: Dialog) -> ConversationView {
    let vm = ConversationViewModel(dialog: dialog,
                                   messgeService: serviceAssembly.messageService,
                                   userService: serviceAssembly.userService)
    return ConversationView(viewModel: vm)
  }
  
  func assemblyProfile() -> ProfileView {
    return ProfileView()
  }
  
  
}

