//
//  LoginViewModel.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var emailOrMobile = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoginSuccess = false
    @Published var loggedInUser: UserEntity?

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login() {
        errorMessage = nil
        guard !emailOrMobile.isEmpty, !password.isEmpty else {
            errorMessage = Constants.Login.errorEmptyFields
            return
        }

        do {
            if let user = try loginUseCase.execute(emailOrMobile: emailOrMobile, password: password) {
                UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.isLoggedIn)
                UserDefaults.standard.set(user.id.uuidString, forKey: Constants.UserDefaultsKeys.loggedInUserId)
                UserDefaults.standard.synchronize()
                loggedInUser = user
                isLoginSuccess = true
            } else {
                errorMessage = Constants.Login.errorInvalidCredentials
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
