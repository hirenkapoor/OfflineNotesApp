//
//  HomeViewModel.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var notes: [NoteEntity] = []
    @Published var errorMessage: String?
    @Published var didLogout = false
    
    private let fetchNotesUseCase: FetchNotesUseCase
    let userId: UUID
    
    init(fetchNotesUseCase: FetchNotesUseCase, userId: UUID) {
        self.fetchNotesUseCase = fetchNotesUseCase
        self.userId = userId
        fetchNotes()
    }
    
    func fetchNotes() {
        do {
            notes = try fetchNotesUseCase.execute(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: Constants.UserDefaultsKeys.isLoggedIn)
        UserDefaults.standard.set("", forKey: Constants.UserDefaultsKeys.loggedInUserId)
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.loggedInUserId)
        UserDefaults.standard.synchronize()
        print("Logout: UserDefaults cleared")

        DispatchQueue.main.async {
            self.didLogout = true
        }
    }
}
