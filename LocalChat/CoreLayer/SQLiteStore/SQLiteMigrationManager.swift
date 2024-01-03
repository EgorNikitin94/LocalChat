//
//  SQLiteMigrationManager.swift
//  LocalChat
//
//  Created by Егор Никитин on 12/25/23.
//

import Foundation
import GRDB

struct SQLiteMigrationManager {
  static var migrator: DatabaseMigrator {
    let migrator = DatabaseMigrator()
    
    return migrator
  }
}
