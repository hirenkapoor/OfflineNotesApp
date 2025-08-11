//
//  Note+Mapping.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import Foundation

extension Note {
    func toEntity() -> NoteEntity {
        NoteEntity(
            id: self.id ?? UUID(),
            title: self.title ?? "",
            desc: self.desc ?? "",
            photos: (self.photos?.allObjects as? [Photo])?.map { $0.toEntity() } ?? []
        )
    }

    func fromEntity(_ entity: NoteEntity) {
        self.id = entity.id
        self.title = entity.title
        self.desc = entity.desc
        let photosSet = NSMutableSet()
        entity.photos.forEach {
            let photoMO = Photo(context: self.managedObjectContext!)
            photoMO.fromEntity($0)
            photosSet.add(photoMO)
        }
        self.photos = photosSet
    }
}
