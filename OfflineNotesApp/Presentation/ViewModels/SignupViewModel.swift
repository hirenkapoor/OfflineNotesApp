//
//  SignupViewModel.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import Combine

final class SignupViewModel: ObservableObject {
    @Published var name = ""
    @Published var mobile = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isSignupSuccess = false

    private let signupUseCase: SignupUseCase

    private var cancellables = Set<AnyCancellable>()

    init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    func signup() {
        errorMessage = nil

        guard Validator.isValidName(name) else {
            errorMessage = Constants.Signup.errorNameLength
            return
        }
        guard Validator.isValidIndianMobile(mobile) else {
            errorMessage = Constants.Signup.errorInvalidMobile
            return
        }
        guard Validator.isValidEmail(email) else {
            errorMessage = Constants.Signup.errorInvalidEmail
            return
        }
        guard Validator.isValidPassword(password, name: name) else {
            errorMessage = Constants.Signup.errorInvalidPassword
            return
        }

        let hashedPassword = CryptoHasher.hash(password)

        let userEntity = UserEntity(id: UUID(), name: name, mobile: mobile, email: email, password: hashedPassword)

        do {
            try signupUseCase.execute(user: userEntity)
            isSignupSuccess = true
        } catch SignupError.userExists {
            errorMessage = Constants.Signup.errorUserExists
        } catch {
            errorMessage = "\(Constants.Signup.errorSignupFailed): \(error.localizedDescription)"
        }
    }

    func clearFields() {
        name = ""
        mobile = ""
        email = ""
        password = ""
        errorMessage = nil
    }
}
