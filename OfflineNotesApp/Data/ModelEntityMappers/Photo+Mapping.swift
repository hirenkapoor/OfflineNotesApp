//
//  Photo+Mapping.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import Foundation

extension Photo {
    func toEntity() -> PhotoEntity {
        PhotoEntity(id: self.id ?? UUID(),
                    imageData: self.imageData ?? Data())
    }

    func fromEntity(_ entity: PhotoEntity) {
        self.id = entity.id
        self.imageData = entity.imageData
    }
}
