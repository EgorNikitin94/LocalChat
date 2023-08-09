//
//  CoreDataStore.swift
//  ImprovedNotes
//
//  Created by Александр Бисеров on 3/17/22.
//

import Foundation
import CoreData

enum RequestType {
    case update
    case delete
}


struct CacheUpdate {
    var propertiesToUpdate: [AnyHashable: Any]
    var predicate: NSPredicate?
}

//class CoreDataStore {
//
//    static let shared = CoreDataStore()
//    
//    private init() {}
//
//
//    // MARK: - Loading
//    func firstModel<T: NSManagedObject>(for modelClass: T.Type, predicate: NSPredicate?) -> T? {
//        return loadModels(for: T.self, predicate: predicate).first
//    }
//
//    func loadModels<T: NSManagedObject>(for modelClass: T.Type, predicate: NSPredicate?) -> [T] {
//        loadModels(for: T.self, predicate: predicate, sortValue: nil, ascending: false)
//    }
//
//    func loadModels<T: NSManagedObject>(for modelClass: T.Type, predicate: NSPredicate?, sortValue: String?, ascending: Bool) -> [T] {
//        let request = modelClass.fetchRequest()
//        request.predicate = predicate
//        if let sortValue = sortValue {
//            request.sortDescriptors = [NSSortDescriptor(key: sortValue, ascending: ascending)]
//        }
//        return fetch(request) as? [T] ?? []
//    }
//
//    func loadTheOnlyProperties<T: NSManagedObject>(_ properties: [String], for modelClass: T.Type, predicate: NSPredicate?) -> [String: Any] {
//        return loadTheOnlyProperties(properties, for: T.self, predicate: predicate, sortValue: nil, ascending: false, fetchLimit: nil)
//    }
//
//    func loadTheOnlyProperties<T: NSManagedObject>(_ properties: [String], for modelClass: T.Type, predicate: NSPredicate?, sortValue: String?, ascending: Bool, fetchLimit: Int?) -> [String: Any] {
//        guard let entityName = modelClass.entity().name else { fatalError() }
//        let request = NSFetchRequest<NSDictionary>(entityName: entityName)
//        request.resultType = .dictionaryResultType
//        request.propertiesToFetch = properties
//        if let fetchLimit = fetchLimit {
//            request.fetchLimit = fetchLimit
//        }
//
//        if let sortValue = sortValue {
//            request.sortDescriptors = [NSSortDescriptor(key: sortValue, ascending: ascending)]
//        }
//
//        let result = fetch(request)
//        let resultDict = result.first
//        guard let returnValue = resultDict as? [String: Any] else { return [:] }
//        return returnValue
//    }
//
//    // MARK: - Update
//    func update<T: NSManagedObject>(_ properties: [AnyHashable: Any], for modelClass: T.Type, predicate: NSPredicate?) {
//        let cacheUpdate = CacheUpdate(propertiesToUpdate: properties, predicate: predicate)
//        let updateRequest = generateBatchUpdateRequest(for: T.self, cacheUpdate: cacheUpdate)
//        guard let changes = execute(updateRequest, requestType: .update) else { return }
//        merge(changes)
//    }
//
//    func update<T: NSManagedObject>(_ cacheUpdates: [CacheUpdate], for modelClass: T.Type) {
//        var changes = [String: [NSManagedObjectID]]()
//        for update in cacheUpdates {
//            let updateRequest = generateBatchUpdateRequest(for: T.self, cacheUpdate: update)
//            changes[NSUpdatedObjectsKey] = execute(updateRequest, requestType: .update)?[NSUpdatedObjectsKey]
//        }
//        merge(changes)
//    }
//
//    func cacehUpdate(propertiesToUpdate: [AnyHashable: Any], predicate: NSPredicate?) -> CacheUpdate {
//        return CacheUpdate(propertiesToUpdate: propertiesToUpdate, predicate: predicate)
//    }
//
//    // MARK: - Delete
//    func deleteModels<T: NSManagedObject>(for modelClass: T.Type, predicate: NSPredicate?) {
//        guard let entityName = modelClass.entity().name else { return }
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        request.predicate = predicate
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//        deleteRequest.resultType = .resultTypeObjectIDs
//        guard let changes = execute(deleteRequest, requestType: .delete) else { return }
//        merge(changes)
//    }
    
    
    // MARK: - Private
//    private func execute(_ request: NSPersistentStoreRequest, requestType: RequestType) -> [String: [NSManagedObjectID]]? {
//        do {
//            switch requestType {
//            case .update:
//                guard
//                    let result = try CoreDataStack.shared.managedContext.execute(request) as? NSBatchUpdateResult,
//                    let changedObjectIDs = result.result as? [NSManagedObjectID]
//                else { return nil }
//                return [NSUpdatedObjectsKey: changedObjectIDs]
//            case .delete:
//                guard
//                    let result = try CoreDataStack.shared.managedContext.execute(request) as? NSBatchDeleteResult,
//                    let changedObjectIDs = result.result as? [NSManagedObjectID]
//                else { return nil }
//                return [NSDeletedObjectsKey: changedObjectIDs]
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//
//    private func merge(_ changes: [String: [NSManagedObjectID]]) {
//        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [CoreDataStack.shared.managedContext])
//    }
//
//
//    private func generateBatchUpdateRequest<T: NSManagedObject>(for modelClass: T.Type, cacheUpdate: CacheUpdate) -> NSBatchUpdateRequest {
//        let batchUpdateRequest = NSBatchUpdateRequest(entity: modelClass.entity())
//        batchUpdateRequest.propertiesToUpdate = cacheUpdate.propertiesToUpdate
//        batchUpdateRequest.predicate = cacheUpdate.predicate
//        batchUpdateRequest.affectedStores = CoreDataStack.shared.managedContext.persistentStoreCoordinator?.persistentStores
//        batchUpdateRequest.resultType = .updatedObjectIDsResultType
//        return batchUpdateRequest
//    }
//
//    private func fetch<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>) -> [T] {
//        do {
//            return try CoreDataStack.shared.managedContext.fetch(request)
//        } catch let error as NSError {
//            fatalError(error.localizedDescription)
//        }
//    }
    
//}
