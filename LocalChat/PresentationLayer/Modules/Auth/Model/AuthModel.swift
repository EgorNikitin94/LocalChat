//
//  AuthModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import Foundation
import Observation

@Observable
class AuthModel: AuthModelStateProtocol {
  var login: String = ""
  var password: String = ""
  var passwordFieldEnabled = false
  var buttonEnabled = false
  var state: State = .none
  var focusedTextField: AuthModel.FocusedField? = nil
  let routerSubject = AuthRouter.Subjects()
  
  enum State: Int {
    case none
    case passwordFieldEnabled
    case buttonEnabled
  }
  
  enum FocusedField {
    case phone
    case code
  }
  
  class PhoneFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
      if let string = obj as? String {
        return formattedPhone(string)
      }
      return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
      obj?.pointee = string as AnyObject?
      return true
    }
    
    private func formattedPhone(_ phone: String?) -> String? {
      guard let number = phone else { return nil }
      let mask = "+# (###) ###-##-##"
      return applyPatternOnNumbers(string: number, pattern: mask, replacmentCharacter: "#")
    }
    
    private func applyPatternOnNumbers(string: String, pattern: String, replacmentCharacter: Character) -> String {
      var pureNumber = string.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
      for index in 0 ..< pattern.count {
        guard index < pureNumber.count else { return pureNumber }
        let stringIndex = String.Index(utf16Offset: index, in: string)
        let patternCharacter = pattern[stringIndex]
        guard patternCharacter != replacmentCharacter else { continue }
        pureNumber.insert(patternCharacter, at: stringIndex)
      }
      return pureNumber
    }
  }
}

// MARK: - Actions
extension AuthModel: AuthModelActionsProtocol {
  func changeState(_ newState: AuthModel.State) {
    state = newState
  }
}

// MARK: - Route
extension AuthModel: AuthModelRouterProtocol {
  func didTapSignIn() {
    routerSubject.screen.send(.testNavigation(param: 1))
  }
}
