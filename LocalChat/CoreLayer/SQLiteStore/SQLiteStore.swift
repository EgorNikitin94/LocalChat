//
//  SQLiteStore.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/12/23.
//

import Foundation
import GRDB

class SQLiteStore {
  static let shared = SQLiteStore()
  
  private let sharedAppGroup = "group.com.localChat"
  private let dataBaseName = "localChatDB.sqlite"
  
  private var dbPool: DatabasePool?
  
  private let enableLogs: Bool = false
  
  // MARK: - Init Database
  func initializeDb() {
    if let containerPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: sharedAppGroup)?.path {
      do {
        let dataBasePath = containerPath + "/" + dataBaseName
        var config = Configuration()
        if enableLogs {
          config.prepareDatabase { db in
            db.trace { print("SQL db: \($0)") }
          }
        }
        let dbQueue = try DatabasePool(path: dataBasePath, configuration: config)
        let migrator = SQLiteMigrationManager.migrator
        try migrator.migrate(dbQueue)
        self.dbPool = dbQueue
      } catch {
        print("SQLite: Init error: \(error)")
      }
    }
  }
}
