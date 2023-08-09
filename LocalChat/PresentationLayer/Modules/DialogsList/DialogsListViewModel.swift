//
//  DialogsListViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import UIKit
import Combine

class DialogsListViewModel: ObservableObject {
  
  @Published var dialogs: [DialogListRowViewModel] = []
  
  private var dialogsService: DialogsServiceProtocol
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  let didComplete = PassthroughSubject<DialogsListViewModel, Never>()
  
  let didTapOnDialog = PassthroughSubject<DialogListRowViewModel, Never>()
  
  init(service: DialogsServiceProtocol) {
    self.dialogsService = service
    
    dialogs = dialogsService.getDialogsList().map({ dialog in
      DialogListRowViewModel(dialog: dialog)
    })
  }
  
  func openProfile() {
    didComplete.send(self)
  }
  
  func openConversation(for dialogVM: DialogListRowViewModel) {
    didTapOnDialog.send(dialogVM)
  }
}

