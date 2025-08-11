//
//  Router.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

import SwiftUI
import Combine

enum AppRoute: Hashable {
    case login
    case signup
    case home(userId: UUID)
    case addNote(userId: UUID)
    case noteDetail(note: NoteEntity)
}

final class Router: ObservableObject {
    @Published var path: [AppRoute] = []

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        path = []
    }
    
    func setRoot(_ route: AppRoute) {
        path = [route]
    }
    
    func resetToLogin() {
        path = [AppRoute.login]
    }
}
