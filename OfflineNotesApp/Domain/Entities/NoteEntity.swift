//
//  NoteEntity.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import Foundation

struct NoteEntity: Hashable {
    let id: UUID
    let title: String
    let desc: String
    let photos: [PhotoEntity]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NoteEntity, rhs: NoteEntity) -> Bool {
        lhs.id == rhs.id
    }
}
