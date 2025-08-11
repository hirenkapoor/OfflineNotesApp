//
//  AddNoteUseCase.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class AddNoteUseCase {
    private let noteRepository: NoteRepositoryProtocol

    init(noteRepository: NoteRepositoryProtocol) {
        self.noteRepository = noteRepository
    }

    func execute(note: NoteEntity, userId: UUID) throws {
        try noteRepository.saveNote(note, userId: userId)
    }
}
