//
//  CoreDataStack.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.appName)
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
