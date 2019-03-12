//
//  Task.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 12/03/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import Foundation
import CoreData

class Task: Operation {

    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext

    // MARK: - Initialization

    init(managedObjectContext: NSManagedObjectContext) {
        // Set Managed Object Context
        self.managedObjectContext = managedObjectContext

        super.init()
    }

    // MARK: - Overrides

    override func main() {
        // ...

        // Save Changes
        saveChanges()
    }

    // MARK: - Helper Methods

    private func saveChanges() {
        managedObjectContext.performAndWait {
            do {
                if self.managedObjectContext.hasChanges {
                    try self.managedObjectContext.save()
                }
            } catch {
                print("Unable to Save Changes of Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
    
}
