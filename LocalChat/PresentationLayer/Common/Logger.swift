//
//  Logger.swift
//  LocalChat
//
//  Created by Егор Никитин on 2/21/24.
//

import Foundation
import OSLog

class Log {
  static let network: Logger = {
    Logger(subsystem: "com.EgorNikitin.LocalChat", category: "Network")
  }()
  
  static let dataBase: Logger = {
    Logger(subsystem: "com.EgorNikitin.LocalChat", category: "SQL")
  }()
  
  static let app: Logger = {
    Logger(subsystem: "com.EgorNikitin.LocalChat", category: "App")
  }()
  
  static func custom(category: String) -> Logger {
    Logger(subsystem: "com.EgorNikitin.LocalChat", category: category)
  }
}
