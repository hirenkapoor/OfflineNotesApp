//
//  NoteRepository.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import CoreData

enum NoteRepositoryError: Error {
    case userNotFound
}

protocol NoteRepositoryProtocol {
    func fetchNotes(forUser userId: UUID) throws -> [NoteEntity]
    func saveNote(_ note: NoteEntity, userId: UUID) throws
}

final class NoteRepository: NoteRepositoryProtocol {
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func fetchNotes(forUser userId: UUID) throws -> [NoteEntity] {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user.id == %@", userId as CVarArg)
        let notes = try context.fetch(fetchRequest)
        return notes.map { $0.toEntity() }
    }

    func saveNote(_ note: NoteEntity, userId: UUID) throws {
        let context = coreDataStack.context

        // Fetch User Managed Object
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "id == %@", userId as CVarArg)
        
        guard let userMO = try context.fetch(userFetch).first else {
            throw NoteRepositoryError.userNotFound
        }

        // Check if Note already exists to avoid duplicates
        let noteFetch: NSFetchRequest<Note> = Note.fetchRequest()
        noteFetch.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        
        if let existingNoteMO = try context.fetch(noteFetch).first {
            existingNoteMO.fromEntity(note)
            existingNoteMO.user = userMO
        } else {
            // Create new Note Managed Object
            let noteMO = Note(context: context)
            noteMO.fromEntity(note)
            noteMO.user = userMO
        }

        try coreDataStack.saveContext()
    }
}
