//
//  RootView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @StateObject var router = Router()
    let container = DIContainer.shared

    func makeLoginVM() -> LoginViewModel {
        LoginViewModel(loginUseCase: container.loginUseCase)
    }

    func makeSignupVM() -> SignupViewModel {
        SignupViewModel(signupUseCase: container.signupUseCase)
    }

    func makeHomeVM(userId: UUID) -> HomeViewModel {
        HomeViewModel(fetchNotesUseCase: container.fetchNotesUseCase, userId: userId)
    }

    func makeAddNoteVM(userId: UUID) -> AddNoteViewModel {
        AddNoteViewModel(addNoteUseCase: container.addNoteUseCase, userId: userId)
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if let firstRoute = router.path.first {
                    switch firstRoute {
                    case .home(let userId):
                        HomeView(vm: makeHomeVM(userId: userId))
                    case .login:
                        LoginView(vm: makeLoginVM())
                    case .signup:
                        SignupView(viewModel: makeSignupVM())
                    default:
                        SignupView(viewModel: makeSignupVM())
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .login:
                    LoginView(vm: makeLoginVM())
                        .navigationBarBackButtonHidden(true)
                case .signup:
                    SignupView(viewModel: makeSignupVM())
                        .navigationBarBackButtonHidden(true)
                case .home(let userId):
                    HomeView(vm: makeHomeVM(userId: userId))
                case .addNote(let userId):
                    AddNoteView(vm: makeAddNoteVM(userId: userId))
                case .noteDetail(let note):
                    NoteDetailView(note: note)
                }
            }
        }
        .environmentObject(router)
        .onAppear {
            let userId = container.userRepository.getLoggedInUserId()
            let isLoggedIn = UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isLoggedIn)
            if let userId = userId, isLoggedIn == true {
                router.setRoot(.home(userId: userId))
            } else {
                router.setRoot(.signup)
            }
        }
    }
}
