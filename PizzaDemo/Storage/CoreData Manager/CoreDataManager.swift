//
//  CoreDataManager.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 12/03/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import CoreData
import Foundation

public class CoreDataManager {

    // MARK: - Type Aliases

    public typealias CoreDataManagerCompletion = () -> ()

    // MARK: - Properties

    private let modelName: String
    private let completion: CoreDataManagerCompletion

    // MARK: - Lifecycle

    public init(modelName: String, completion: @escaping CoreDataManagerCompletion) {
        self.modelName = modelName
        self.completion = completion

        // Setup Core Data Stack
        setupCoreDataStack()
    }

    // MARK: - Core Data Stack

    private func setupCoreDataStack() {
        // Fetch Persistent Store Coordinator
        guard let persistentStoreCoordinator = mainManagedObjectContext.persistentStoreCoordinator else {
            fatalError("Unable to Set Up Core Data Stack")
        }

        DispatchQueue.global().async {
            // Add Persistent Store
            self.addPersistentStore(to: persistentStoreCoordinator)

            // Invoke Completion On Main Queue
            DispatchQueue.main.async { self.completion() }
        }
    }

    private func addPersistentStore(to persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        // Helpers
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        // URL Documents Directory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        // URL Persistent Store
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption : true,
                NSInferMappingModelAutomaticallyOption : true
            ]

            // Add Persistent Store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)

        } catch {
            fatalError("Unable to Add Persistent Store")
        }
    }

    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        // Initialize Managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        return NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    }()

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize PRIVATE Managed Object Context that uses a private concurrency queue.
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    public private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.parent = self.privateManagedObjectContext

        return managedObjectContext
    }()

    public func privateChildManagedObjectContext() -> NSManagedObjectContext {
        // Initialize PRIVATE CHILD Managed Object Context that uses a private concurrency queue.
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.parent = mainManagedObjectContext

        return managedObjectContext
    }

    // MARK: - Public API

    public func saveChanges() {
        mainManagedObjectContext.performAndWait {
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }

        privateManagedObjectContext.perform {
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                }
            } catch {
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }

}
