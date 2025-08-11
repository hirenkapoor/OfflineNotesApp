//
//  Model.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

extension User {
    func toEntity() -> UserEntity {
        UserEntity(id: self.id ?? UUID(),
                   name: self.name ?? "",
                   mobile: self.mobile ?? "",
                   email: self.email ?? "",
                   password: self.password ?? "")
    }

    func fromEntity(_ entity: UserEntity) {
        self.id = entity.id
        self.name = entity.name
        self.mobile = entity.mobile
        self.email = entity.email
        self.password = entity.password
    }
}
