//
//  AddNoteViewModel.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import UIKit

final class AddNoteViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var photos: [UIImage] = []
    @Published var errorMessage: String?
    @Published var isNoteSaved = false

    private let addNoteUseCase: AddNoteUseCase
    private let userId: UUID
    private let maxImageDimension: CGFloat = 1024

    init(addNoteUseCase: AddNoteUseCase, userId: UUID) {
        self.addNoteUseCase = addNoteUseCase
        self.userId = userId
    }

    func addPhoto(_ image: UIImage) {
        guard photos.count < 10 else { return }

        guard let resized = image.resized(to: maxImageDimension),
              let compressedData = resized.jpegData(compressionQuality: 0.8),
              let compressedImage = UIImage(data: compressedData) else {
            errorMessage = Constants.AddNote.errorProcessImage
            return
        }

        photos.append(compressedImage)
    }

    func saveNote() {
        errorMessage = nil

        guard Validator.isValidTitle(title) else {
            errorMessage = Constants.AddNote.errorInvalidTitle
            return
        }

        guard Validator.isValidDescription(description) else {
            errorMessage = Constants.AddNote.errorInvalidDescription
            return
        }

        guard !photos.isEmpty else {
            errorMessage = Constants.AddNote.errorNoPhotos
            return
        }

        let photoEntities = photos.compactMap { image -> PhotoEntity? in
            guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
            return PhotoEntity(id: UUID(), imageData: data)
        }

        let note = NoteEntity(id: UUID(), title: title, desc: description, photos: photoEntities)

        do {
            try addNoteUseCase.execute(note: note, userId: userId)
            isNoteSaved = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func clearFields() {
        title = ""
        description = ""
        photos = []
        errorMessage = nil
    }
}
