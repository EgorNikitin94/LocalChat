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

@propertyWrapper
struct UserDefaultEncoded<T: Codable> {
  let key: String
  private let defaultValue: T
  private let store: UserDefaults
  
  init(key: String, store: UserDefaults = UserDefaults.standard, default: T) {
    self.key = key
    self.store = store
    defaultValue = `default`
  }
  
  var wrappedValue: T {
    get {
      guard let jsonString = UserDefaults.standard.string(forKey: key) else {
        return defaultValue
      }
      guard let jsonData = jsonString.data(using: .utf8) else {
        return defaultValue
      }
      guard let value = try? JSONDecoder().decode(T.self, from: jsonData) else {
        return defaultValue
      }
      return value
    }
    set {
      let encoder = JSONEncoder()
      encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
      guard let jsonData = try? encoder.encode(newValue) else { return }
      let jsonString = String(bytes: jsonData, encoding: .utf8)
      UserDefaults.standard.set(jsonString, forKey: key)
    }
  }
}
