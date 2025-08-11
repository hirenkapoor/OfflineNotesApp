//
//  FetchNotesUseCase.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class FetchNotesUseCase {
    private let noteRepository: NoteRepositoryProtocol

    init(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }

    func execute(userId: UUID) throws -> [NoteEntity] {
        try noteRepository.fetchNotes(forUser: userId)
    }
}
