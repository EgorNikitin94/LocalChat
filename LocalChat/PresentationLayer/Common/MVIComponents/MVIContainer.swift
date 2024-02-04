//
//  MVIContainer.swift
//  amomessenger
//
//  Created by Egor Nikitin on 08/06/2023.
//  Copyright © 2023 amoCRM. All rights reserved.
//

import SwiftUI
import Combine
import Observation

final class MVIContainer<Intent, Model>: ObservableObject {
  
  // MARK: Public
  
  let intent: Intent
  var model: Model
  
  // MARK: private
  
  private var cancellable: Set<AnyCancellable> = []
  
  // MARK: Life cycle
  
  init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
    self.intent = intent
    self.model = model
    
    modelChangePublisher
      .receive(on: RunLoop.main)
      .sink(receiveValue: objectWillChange.send)
      .store(in: &cancellable)
  }
}

@Observable
final class ModernMVIContainer<Intent, Model> {
  let intent: Intent
  var model: Model
  
  init(intent: Intent, model: Model) {
    self.intent = intent
    self.model = model
  }
}
