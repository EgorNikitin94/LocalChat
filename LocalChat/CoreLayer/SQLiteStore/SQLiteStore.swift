//
//  SQLiteStore.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/12/23.
//

import Foundation
import GRDB

protocol SQLiteEntity: SQLiteRecordEntity & SQLiteFetchEntity {}
protocol SQLiteRecordEntity: Encodable, PersistableRecord {}
protocol SQLiteFetchEntity: Decodable, FetchableRecord {}

class SQLiteStore {
  static let shared = SQLiteStore()
  
  private let sharedAppGroup = "group.com.localChat"
  private let dataBaseName = "localChatDB.sqlite"
  
  private var dbPool: DatabasePool?
  
  private let enableLogs: Bool = false
  
  enum DBError: Error {
    case dbPoolNotExists
  }
  
  // MARK: - Init Database
  func initializeDb() {
    if let containerPath = FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: sharedAppGroup
    )?.path {
      do {
        let dataBasePath = containerPath + "/" + dataBaseName
        var config = Configuration()
        if enableLogs {
          config.prepareDatabase { db in
            db.trace({ Log.dataBase.info("SQLite db<: \($0)") })
          }
        }
        let dbPool = try DatabasePool(
          path: dataBasePath,
          configuration: config
        )
        let migrator = SQLiteMigrationManager.migrator
        try migrator.migrate(dbPool)
        self.dbPool = dbPool
      } catch {
        Log.dataBase.error("Init error: \(error)")
      }
    }
  }
  
  // MARK: - Clear Database
  func performCleanup() async throws {
    try await dbPool?.write({ db in
      // MARK: TODO
    })
  }
  
  // MARK: - Write Models
  func write<T: SQLiteRecordEntity>(model: T) async throws {
    try await dbPool?.write({ db in
      try model.save(db)
    })
  }
  
  func write<T: SQLiteRecordEntity>(models: [T]) async throws {
    try await dbPool?.write({ db in
      try models.forEach { model in
        try model.save(db)
      }
    })
  }
  
  func executeWrite(query: String, arguments: StatementArguments = []) async throws {
    try await dbPool?.write({ db in
      try db.execute(sql: query, arguments: arguments)
    })
  }
  
  // MARK: - Update Models
  @discardableResult
  func update<T: SQLiteFetchEntity>(
    request: QueryInterfaceRequest<T>,
    onConflict conflictResolution: Database.ConflictResolution? = nil,
    _ assignments: ColumnAssignment...
  ) async throws -> Int {
    try await dbPool?.write({ db in
      try request.updateAll(db, onConflict: conflictResolution, assignments)
    }) ?? 0
  }
  
  func updateAndFetchAll<T: SQLiteEntity>(
    request: QueryInterfaceRequest<T>,
    onConflict conflictResolution: Database.ConflictResolution? = nil,
    _ assignments: ColumnAssignment...
  ) async throws -> [T] {
    try await dbPool?.write({ db in
      try request.updateAndFetchAll(db, onConflict: conflictResolution, assignments)
    }) ?? []
  }
  
  func updateAndFetchSet<T: SQLiteEntity>(
    request: QueryInterfaceRequest<T>,
    onConflict conflictResolution: Database.ConflictResolution? = nil,
    _ assignments: ColumnAssignment...
  ) async throws -> Set<T> {
    try await dbPool?.write({ db in
      try request.updateAndFetchSet(db, onConflict: conflictResolution, assignments)
    }) ?? Set<T>()
  }
  
  // MARK: - Read Models
  func fetchCount<T: SQLiteFetchEntity>(request: QueryInterfaceRequest<T>) async throws -> Int {
    try await dbPool?.read({ db in
      try request.fetchCount(db)
    }) ?? 0
  }
  
  func fetchOne<T: SQLiteFetchEntity>(request: QueryInterfaceRequest<T>) async throws -> T? {
    try await dbPool?.read({ db in
      try request.fetchOne(db)
    })
  }
  
  func fetch<T: SQLiteFetchEntity>(request: QueryInterfaceRequest<T>) async throws -> [T] {
    try await dbPool?.read({ db in
      try request.fetchAll(db)
    }) ?? []
  }
  
  func fetchSet<T: SQLiteFetchEntity>(request: QueryInterfaceRequest<T>) async throws -> Set<T> {
    try await dbPool?.read({ db in
      try request.fetchSet(db)
    }) ?? Set<T>()
  }
  
  func fetch<T: DatabaseValueConvertible & StatementColumnConvertible>(sqlRequest: SQLRequest<T>) async throws -> [T] {
    try await dbPool?.read({ db in
      try sqlRequest.fetchAll(db)
    }) ?? []
  }
  
  func fetch<T: SQLiteFetchEntity>(sqlRequest: SQLRequest<T>) async throws -> [T] {
    try await dbPool?.read({ db in
      try sqlRequest.fetchAll(db)
    }) ?? []
  }
  
//  func fetch<each T: SQLiteFetchEntity>(_ requests: repeat QueryInterfaceRequest<each T>) async throws -> (repeat [each T]) {
//    let dbPool = try getDatabasePool()
//    try await dbPool.read({ db in
//      return (try repeat (each requests).fetchAll(db))
//    })
//  }
  
  // MARK: - Select Fields from Models
  func select<T: DatabaseValueConvertible & StatementColumnConvertible>(request: QueryInterfaceRequest<T>) async throws -> [T] {
    try await dbPool?.read({ db in
      try request.fetchAll(db)
    }) ?? []
  }
  
  func select(request: QueryInterfaceRequest<Row>) async throws -> [Row] {
    try await dbPool?.read({ db in
      try request.fetchAll(db)
    }) ?? []
  }
  
  // MARK: - Delete Models
  @discardableResult
  func delete<T: SQLiteRecordEntity>(model: T) async throws -> Bool {
    return try await dbPool?.write({ db in
      try model.delete(db)
    }) ?? false
  }
  
  func delete<T: SQLiteRecordEntity>(models: [T]) async throws {
    let _ = try await dbPool?.write({ db in
      try models.forEach { model in
        try model.delete(db)
      }
    })
  }
  
  func delete<T: SQLiteRecordEntity>(request: QueryInterfaceRequest<T>) async throws -> Int {
    try await dbPool?.write({ db in
      try request.deleteAll(db)
    }) ?? 0
  }
  
  // MARK: - Private
  private func getDatabasePool() throws -> DatabasePool {
    guard let dbPool = dbPool else { throw DBError.dbPoolNotExists }
    return dbPool
  }
}
