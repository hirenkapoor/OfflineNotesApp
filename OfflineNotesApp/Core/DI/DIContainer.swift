//
//  DIContainer.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
final class DIContainer {
    static let shared = DIContainer()

    let coreDataStack = CoreDataStack.shared

    lazy var userRepository: UserRepositoryProtocol = UserRepository(coreDataStack: coreDataStack)
    lazy var noteRepository: NoteRepositoryProtocol = NoteRepository(coreDataStack: coreDataStack)

    lazy var signupUseCase = SignupUseCase(userRepository: userRepository)
    lazy var loginUseCase = LoginUseCase(userRepository: userRepository)
    lazy var fetchNotesUseCase = FetchNotesUseCase(noteRepository: noteRepository)
    lazy var addNoteUseCase = AddNoteUseCase(noteRepository: noteRepository)
}
