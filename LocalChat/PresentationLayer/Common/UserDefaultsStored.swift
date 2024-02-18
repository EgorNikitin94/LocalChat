//
//  UserDefaultsStorage.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/19/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsStored<T> {
  private let key: String
  private let defaultValue: T
  private let store: UserDefaults
  
  init(key: String, store: UserDefaults = UserDefaults.standard, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
    self.store = store
  }
  
  var wrappedValue: T {
    get {
      // Read value from UserDefaults
      return store.value(forKey: key) as? T ?? defaultValue
    }
    set {
      // Set value to UserDefaults
      store.set(newValue, forKey: key)
    }
  }
}
