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
  
  private var dialogsService: MockDialogsService//any DialogsServiceProtocol
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    self.dialogsService = MockDialogsService()
    
    let allItemsSubscription = dialogsService.$models.sink { items in
        
    }
    
    dialogs = dialogsService.getDialogsList().map({ dialog in
      DialogListRowViewModel(dialog: dialog)
    })
  }
}

