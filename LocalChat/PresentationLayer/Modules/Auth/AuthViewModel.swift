//
//  LogInViewModel.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
  
  @Published var name: String = ""
  
  @Published var password: String = ""
  
  @Published var hidePasswordInput: Bool = true
  
  @Published var bottonDisabled: Bool = true
  
  let service: AuthServiceProtocol
  
  private(set) var cancellableSet: Set<AnyCancellable> = []
  
  init(service: AuthServiceProtocol) {
    self.service = service
    
    isNameValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.hidePasswordInput, on: self)
      .store(in: &cancellableSet)
    
    isBottonDisabled
      .receive(on: RunLoop.main)
      .assign(to: \.bottonDisabled, on: self)
      .store(in: &cancellableSet)
  }
  
  private var isNameValidPublisher: AnyPublisher<Bool, Never> {
    $name
      .debounce(for: 0.3, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
        return !(input.count >= 3)
      }
      .eraseToAnyPublisher()
  }
  
  private var isPassordValidPublisher: AnyPublisher<Bool, Never> {
    $password
      .debounce(for: 0.3, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { input in
        return input.count > 4
      }
      .eraseToAnyPublisher()
  }
  
  private var isBottonDisabled: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(isNameValidPublisher, isPassordValidPublisher)
      .map { isNameValid, isPassordValid in
        return !(!isNameValid && isPassordValid)
      }
      .eraseToAnyPublisher()
  }
  
}
